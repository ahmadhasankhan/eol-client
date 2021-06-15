module Eol
  class GoodsDeliveryLine
    # TODO: Fill out mandatory and other attributes
    include Eol::Resource
    include Eol::SharedSalesAttributes

    # For some reason the Exact API for GoodsDelivery requires us to specify
    # the fields we want returned.  This isn't required for other calls.  :/
    # We get around this by specifying a wildcard on the $select param.
    def find_all(options = {})
      @order_by = options[:order_by]
      @select = options[:select] ||= ['*']
      response = get(uri([:order, :select]))
      response.results if response
    end

    def base_path
      "salesorder/GoodsDeliveryLines"
    end

    def mandatory_attributes
      [:delivery_date, :item, :line_number, :sales_order_number]
    end

    def other_attributes
      SHARED_LINE_ATTRIBUTES.inject(
        [
          :quantity_delivered, :quantity_ordered,
          :sales_order_line_id, :sales_order_line_number,
          :serial_numbers, :storage_location,
          :tracking_number, :unit_code
        ],
        :<<
      )
    end

  end
end
