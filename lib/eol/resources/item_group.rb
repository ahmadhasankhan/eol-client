# frozen_string_literal: true

module Eol
  class ItemGroup
    include Eol::Resource

    def valid_actions
      %i[get]
    end

    def base_path
      "logistics/ItemGroups"
    end

    def other_attributes
      %i[code]
    end

    def mandatory_attributes
      []
    end
  end
end
