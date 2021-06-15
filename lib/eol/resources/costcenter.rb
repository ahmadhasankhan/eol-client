# frozen_string_literal: true

module Eol
  class Costcenter
    include Eol::Resource

    def base_path
      "hrm/Costcenters"
    end

    def mandatory_attributes
      %i[code description]
    end

    def other_attributes
      %i[active]
    end
  end
end
