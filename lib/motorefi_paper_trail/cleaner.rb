# frozen_string_literal: true

module MotorefiPaperTrail
  # Utilities for deleting version records.
  module Cleaner
    # Destroys all but the most recent version(s) for items on a given date
    # (or on all dates). Useful for deleting drafts.
    #
    # Options:
    #
    # - :keeping - An `integer` indicating the number of motorefi_versions to be kept for
    #   each item per date. Defaults to `1`. The most recent matching motorefi_versions
    #   are kept.
    # - :date - Should either be a `Date` object specifying which date to
    #   destroy motorefi_versions for or `:all`, which will specify that all dates
    #   should be cleaned. Defaults to `:all`.
    # - :item_id - The `id` for the item to be cleaned on, or `nil`, which
    #   causes all items to be cleaned. Defaults to `nil`.
    #
    def clean_versions!(options = {})
      options = { keeping: 1, date: :all }.merge(options)
      gather_versions(options[:item_id], options[:date]).each do |_item_id, item_versions|
        group_versions_by_date(item_versions).each do |_date, date_versions|
          # Remove the number of motorefi_versions we wish to keep from the collection
          # of motorefi_versions prior to destruction.
          date_versions.pop(options[:keeping])
          date_versions.map(&:destroy)
        end
      end
    end

    private

    # Returns a hash of motorefi_versions grouped by the `item_id` attribute formatted
    # like this: {:item_id => MotorefiPaperTrail::Version}. If `item_id` or `date` is
    # set, motorefi_versions will be narrowed to those pointing at items with those ids
    # that were created on specified date. Versions are returned in
    # chronological order.
    def gather_versions(item_id = nil, date = :all)
      unless date == :all || date.respond_to?(:to_date)
        raise ArgumentError, "Expected date to be a Timestamp or :all"
      end
      motorefi_versions = item_id ? MotorefiPaperTrail::Version.where(item_id: item_id) : MotorefiPaperTrail::Version
      motorefi_versions = motorefi_versions.order(MotorefiPaperTrail::Version.timestamp_sort_order)
      motorefi_versions = motorefi_versions.between(date.to_date, date.to_date + 1.day) unless date == :all

      # If `motorefi_versions` has not been converted to an ActiveRecord::Relation yet,
      # do so now.
      motorefi_versions = MotorefiPaperTrail::Version.all if motorefi_versions == MotorefiPaperTrail::Version
      motorefi_versions.group_by(&:item_id)
    end

    # Given an array of motorefi_versions, returns a hash mapping dates to arrays of
    # motorefi_versions.
    # @api private
    def group_versions_by_date(motorefi_versions)
      motorefi_versions.group_by { |v| v.created_at.to_date }
    end
  end
end
