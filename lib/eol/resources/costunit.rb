# frozen_string_literal: true

module Eol
  class Costunit
    include Eol::Resource

    def base_path
      "hrm/Costunits"
    end

    def mandatory_attributes
      %i[code description]
    end

    def other_attributes
      %i[account]
    end
  end
end
