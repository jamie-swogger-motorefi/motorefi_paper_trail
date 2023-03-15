# frozen_string_literal: true

# before hook for Cucumber
Before do
  MotorefiPaperTrail.enabled = false
  MotorefiPaperTrail.request.enabled = true
  MotorefiPaperTrail.request.whodunnit = nil
  MotorefiPaperTrail.request.controller_info = {} if defined?(::Rails)
end

module MotorefiPaperTrail
  module Cucumber
    # Helper method for enabling PT in Cucumber features.
    module Extensions
      # :call-seq:
      # with_versioning
      #
      # enable versioning for specific blocks

      def with_versioning
        was_enabled = ::MotorefiPaperTrail.enabled?
        ::MotorefiPaperTrail.enabled = true
        begin
          yield
        ensure
          ::MotorefiPaperTrail.enabled = was_enabled
        end
      end
    end
  end
end

World MotorefiPaperTrail::Cucumber::Extensions
