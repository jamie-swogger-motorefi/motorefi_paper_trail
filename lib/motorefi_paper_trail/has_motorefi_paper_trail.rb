# frozen_string_literal: true

require "motorefi_paper_trail/attribute_serializers/object_attribute"
require "motorefi_paper_trail/attribute_serializers/object_changes_attribute"
require "motorefi_paper_trail/model_config"
require "motorefi_paper_trail/record_trail"

module MotorefiPaperTrail
  # Extensions to `ActiveRecord::Base`.  See `frameworks/active_record.rb`.
  # It is our goal to have the smallest possible footprint here, because
  # `ActiveRecord::Base` is a very crowded namespace! That is why we introduced
  # `.motorefi_paper_trail` and `#motorefi_paper_trail`.
  module Model
    def self.included(base)
      base.extend ClassMethods
    end

    # :nodoc:
    module ClassMethods
      # Declare this in your model to track every create, update, and destroy.
      # Each version of the model is available in the `motorefi_versions` association.
      #
      # Options:
      #
      # - :on - The events to track (optional; defaults to all of them). Set
      #   to an array of `:create`, `:update`, `:destroy` and `:touch` as desired.
      # - :class_name (deprecated) - The name of a custom Version class that
      #   includes `MotorefiPaperTrail::VersionConcern`.
      # - :ignore - An array of attributes for which a new `Version` will not be
      #   created if only they change. It can also accept a Hash as an
      #   argument where the key is the attribute to ignore (a `String` or
      #   `Symbol`), which will only be ignored if the value is a `Proc` which
      #   returns truthily.
      # - :if, :unless - Procs that allow to specify conditions when to save
      #   motorefi_versions for an object.
      # - :only - Inverse of `ignore`. A new `Version` will be created only
      #   for these attributes if supplied it can also accept a Hash as an
      #   argument where the key is the attribute to track (a `String` or
      #   `Symbol`), which will only be counted if the value is a `Proc` which
      #   returns truthily.
      # - :skip - Fields to ignore completely.  As with `ignore`, updates to
      #   these fields will not create a new `Version`.  In addition, these
      #   fields will not be included in the serialized motorefi_versions of the object
      #   whenever a new `Version` is created.
      # - :meta - A hash of extra data to store. You must add a column to the
      #   `motorefi_versions` table for each key. Values are objects or procs (which
      #   are called with `self`, i.e. the model with the paper trail).  See
      #   `MotorefiPaperTrail::Controller.info_for_motorefi_paper_trail` for how to store data
      #   from the controller.
      # - :motorefi_versions - Either,
      #   - A String (deprecated) - The name to use for the motorefi_versions
      #     association.  Default is `:motorefi_versions`.
      #   - A Hash - options passed to `has_many`, plus `name:` and `scope:`.
      # - :version - The name to use for the method which returns the version
      #   the instance was reified from. Default is `:version`.
      #
      # Plugins like the experimental `motorefi_paper_trail-association_tracking` gem
      # may accept additional options.
      #
      # You can define a default set of options via the configurable
      # `MotorefiPaperTrail.config.has_motorefi_paper_trail_defaults` hash in your applications
      # initializer. The hash can contain any of the following options and will
      # provide an overridable default for all models.
      #
      # @api public
      def has_motorefi_paper_trail(options = {})
        defaults = MotorefiPaperTrail.config.has_motorefi_paper_trail_defaults
        motorefi_paper_trail.setup(defaults.merge(options))
      end

      # @api public
      def motorefi_paper_trail
        ::MotorefiPaperTrail::ModelConfig.new(self)
      end
    end

    # Wrap the following methods in a module so we can include them only in the
    # ActiveRecord models that declare `has_motorefi_paper_trail`.
    module InstanceMethods
      # @api public
      def motorefi_paper_trail
        ::MotorefiPaperTrail::RecordTrail.new(self)
      end
    end
  end
end
