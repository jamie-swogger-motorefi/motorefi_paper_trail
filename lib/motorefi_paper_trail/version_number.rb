# frozen_string_literal: true

module MotorefiPaperTrail
  # The version number of the motorefi_paper_trail gem. Not to be confused with
  # `MotorefiPaperTrail::Version`. Ruby constants are case-sensitive, apparently,
  # and they are two different modules! It would be nice to remove `VERSION`,
  # because of this confusion, but it's not worth the breaking change.
  # People are encouraged to use `MotorefiPaperTrail.gem_version` instead.
  module VERSION
    MAJOR = 14
    MINOR = 0
    TINY = 0

    # Set PRE to nil unless it's a pre-release (beta, rc, etc.)
    PRE = nil

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join(".").freeze

    def self.to_s
      STRING
    end
  end
end