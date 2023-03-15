# frozen_string_literal: true

# Demonstrates a table that omits the `object` column.
class NoObjectVersion < ::MotorefiPaperTrail::Version
  self.table_name = "no_object_versions"
end
