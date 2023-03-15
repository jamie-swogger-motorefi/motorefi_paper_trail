# frozen_string_literal: true

require_relative "../migration_generator"

module MotorefiPaperTrail
  # Updates STI entries for MotorefiPaperTrail
  class UpdateItemSubtypeGenerator < MigrationGenerator
    source_root File.expand_path("templates", __dir__)

    desc(
      "Generates (but does not run) a migration to update item_subtype for "\
      "STI entries in an existing motorefi_versions table."
    )

    def create_migration_file
      add_motorefi_paper_trail_migration("update_versions_for_item_subtype", sti_type_options: options)
    end
  end
end
