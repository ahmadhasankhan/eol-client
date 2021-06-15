# frozen_string_literal: true

module Eol
  class SalesEntryLine < Eol::BaseEntryLine
    # A sales entry line belongs to a sales entry
    include Eol::Resource

    def base_path
      "salesentry/SalesEntryLines"
    end
  end
end
