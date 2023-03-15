# frozen_string_literal: true

require "motorefi_paper_trail/events/base"

module MotorefiPaperTrail
  module Events
    # See docs in `Base`.
    #
    # @api private
    class Create < Base
      # Return attributes of nascent `Version` record.
      #
      # @api private
      def data
        data = {
          item: @record,
          event: @record.motorefi_paper_trail_event || "create",
          whodunnit: MotorefiPaperTrail.request.whodunnit
        }
        if @record.respond_to?(:updated_at)
          data[:created_at] = @record.updated_at
        end
        if record_object_changes? && changed_notably?
          changes = notable_changes
          data[:object_changes] = prepare_object_changes(changes)
        end
        merge_item_subtype_into(data)
        merge_metadata_into(data)
      end
    end
  end
end
