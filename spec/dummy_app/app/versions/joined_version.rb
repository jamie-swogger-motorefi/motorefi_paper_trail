# frozen_string_literal: true

# The purpose of this custom version class is to test the scope methods on the
# VersionConcern::ClassMethods module. See
# https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/issues/295 for more details.
class JoinedVersion < MotorefiPaperTrail::Version
  default_scope { joins("INNER JOIN widgets ON widgets.id = motorefi_versions.item_id") }
end
