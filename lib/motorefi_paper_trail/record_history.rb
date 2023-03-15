# frozen_string_literal: true

module MotorefiPaperTrail
  # Represents the history of a single record.
  # @api private
  class RecordHistory
    # @param motorefi_versions - ActiveRecord::Relation - All motorefi_versions of the record.
    # @param version_class - Class - Usually MotorefiPaperTrail::Version,
    #   but it could also be a custom version class.
    # @api private
    def initialize(motorefi_versions, version_class)
      @motorefi_versions = motorefi_versions
      @version_class = version_class
    end

    # Returns ordinal position of `version` in `sequence`.
    # @api private
    def index(version)
      sequence.to_a.index(version)
    end

    private

    # Returns `@motorefi_versions` in chronological order.
    # @api private
    def sequence
      if @version_class.primary_key_is_int?
        @motorefi_versions.select(primary_key).order(primary_key.asc)
      else
        @motorefi_versions.
          select([table[:created_at], primary_key]).
          order(@version_class.timestamp_sort_order)
      end
    end

    # @return - Arel::Attribute - Attribute representing the primary key
    #   of the version table. The column's data type is usually a serial
    #   integer (the rails convention) but not always.
    # @api private
    def primary_key
      table[@version_class.primary_key]
    end

    # @return - Arel::Table - The version table, usually named `motorefi_versions`, but
    #   not always.
    # @api private
    def table
      @version_class.arel_table
    end
  end
end
