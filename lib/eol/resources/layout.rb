# frozen_string_literal: true

module Eol
  class Layout
    include Eol::Resource

    def valid_actions
      %i[get]
    end

    def base_path
      "salesinvoice/Layouts"
    end

    def mandatory_attributes
      []
    end

    def other_attributes
      %i[
        id created creator creator_full_name division
        modified modifier modifier_full_name subject type
      ]
    end
  end
end
