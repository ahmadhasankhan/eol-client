# frozen_string_literal: true

module Eol
  class BankEntryLine < Eol::BaseEntryLine
    # A sales entry line belongs to a sales entry
    include Eol::Resource

    def base_path
      "financialtransaction/BankEntryLines"
    end

    def other_attributes
      %i[
        account amount_VATFC asset cost_center cost_unit date
        description notes document exchange_rate our_ref
        project quantity VAT_code VAT_percentage VAT_type
      ]
    end
  end
end
