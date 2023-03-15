# frozen_string_literal: true

require "motorefi_paper_trail/events/base"

module MotorefiPaperTrail
  module Events
    # See docs in `Base`.
    #
    # @api private
    class Destroy < Base
      # Return attributes of nascent `Version` record.
      #
      # @api private
      def data
        data = {
          item_id: @record.id,
          item_type: @record.class.base_class.name,
          event: @record.motorefi_paper_trail_event || "destroy",
          whodunnit: MotorefiPaperTrail.request.whodunnit
        }
        if record_object?
          data[:object] = recordable_object(false)
        end
        if record_object_changes?
          data[:object_changes] = prepare_object_changes(notable_changes)
        end
        merge_item_subtype_into(data)
        merge_metadata_into(data)
      end

      private

      # Rails' implementation (eg. `@record.saved_changes`) returns nothing on
      # destroy, so we have to build the hash we want.
      #
      # @override
      def changes_in_latest_version
        @record.attributes.transform_values { |value| [value, nil] }
      end
    end
  end
end
