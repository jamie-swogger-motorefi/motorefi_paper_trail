# frozen_string_literal: true

require "singleton"
require "motorefi_paper_trail/serializers/yaml"

module MotorefiPaperTrail
  # Global configuration affecting all threads. Some thread-specific
  # configuration can be found in `motorefi_paper_trail.rb`, others in `controller.rb`.
  class Config
    include Singleton

    attr_accessor(
      :association_reify_error_behaviour,
      :object_changes_adapter,
      :serializer,
      :version_limit,
      :has_motorefi_paper_trail_defaults
    )

    def initialize
      # Variables which affect all threads, whose access is synchronized.
      @mutex = Mutex.new
      @enabled = true

      # Variables which affect all threads, whose access is *not* synchronized.
      @serializer = MotorefiPaperTrail::Serializers::YAML
      @has_motorefi_paper_trail_defaults = {}
    end

    # Indicates whether MotorefiPaperTrail is on or off. Default: true.
    def enabled
      @mutex.synchronize { !!@enabled }
    end

    def enabled=(enable)
      @mutex.synchronize { @enabled = enable }
    end
  end
end
