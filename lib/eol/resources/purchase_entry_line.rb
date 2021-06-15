# frozen_string_literal: true

module Eol
  class PurchaseEntryLine < Eol::BaseEntryLine
    include Eol::Resource

    def base_path
      "purchaseentry/PurchaseEntryLines"
    end
  end
end
