# frozen_string_literal: true

module Eol
  class Version
    MAJOR = 1
    MINOR = 0
    PATCH = 1

    class << self
      def to_s
        [MAJOR, MINOR, PATCH].compact.join(".")
      end
    end
  end
end
