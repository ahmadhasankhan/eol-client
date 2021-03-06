# frozen_string_literal: true

module Eol
  class GeneralJournalEntry
    include Eol::Resource

    def base_path
      "generaljournalentry/GeneralJournalEntries"
    end

    def mandatory_attributes
      %i[journal_code general_journal_entry_lines]
    end

    def other_attributes
      %i[financial_period financial_year currency exchange_rate reversal]
    end
  end
end
