# frozen_string_literal: true

module Eol
  class GeneralJournalEntryLine < Eol::BaseEntryLine
    include Eol::Resource

    def base_path
      "generaljournalentry/GeneralJournalEntryLines"
    end
  end
end
