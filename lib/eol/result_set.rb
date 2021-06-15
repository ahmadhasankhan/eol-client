# frozen_string_literal: true

module Eol
  class ResultSet
    attr_reader :records

    def initialize(parsed_response)
      @parsed_response = parsed_response

      @records = if @parsed_response.results
                   @parsed_response.results.map do |attributes|
                     resource_class.send(:new, attributes)
                   end
                 else
                   [resource_class.send(:new, @parsed_response.result)]
                 end
    end

    def next_page
      return unless next_page_url
      next_page = Eol.get(next_page_url, use_raw_path: true)
      return unless next_page

      response = Eol::Response.new(next_page)
      response.results
    end

    def first
      records.first
    end

    protected

    def next_page_url
      @parsed_response.next_page_url
    end

    def type
      if @parsed_response.metadata
        c_type = @parsed_response.metadata["type"]
      elsif @parsed_response.results.any?
        c_type = @parsed_response.results.first["__metadata"]["type"]
      end
      c_type.split(".").last
    end

    def resource_class
      @resource_class ||= begin
        constant_name = type.classify
        raise NameError unless constant_name =~ /\A[a-zA-Z0-9]+\z/

        klass = Eol.const_get(constant_name, false)
        raise NameError unless klass.included_modules.include?(Eol::Resource)

        klass
      rescue NameError
        Eol.info("Unknown resource encountered, proceed as usual but further resource details might have to be implemented")
        Class.new { include Eol::Resource }
      end
    end
  end
end
