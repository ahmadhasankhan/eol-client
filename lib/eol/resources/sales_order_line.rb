# frozen_string_literal: true

module Eol
  class SalesOrderLine
    include Eol::Resource
    include Eol::SharedSalesAttributes

    def base_path
      "salesorder/SalesOrderLines"
    end

    def mandatory_attributes
      %i[item order_ID]
    end

    def other_attributes
      SHARED_LINE_ATTRIBUTES.inject(
        %i[amount_FC delivery_date item_version order_number unit_price use_drop_shipment VAT_amount],
        :<<
      )
    end
  end
end
