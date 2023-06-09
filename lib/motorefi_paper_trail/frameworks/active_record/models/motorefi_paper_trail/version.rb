# frozen_string_literal: true

require "motorefi_paper_trail/version_concern"

module MotorefiPaperTrail
  # This is the default ActiveRecord model provided by MotorefiPaperTrail. Most simple
  # applications will use this model as-is, but it is possible to sub-class,
  # extend, or even do without this model entirely. See documentation section
  # 6.a. Custom Version Classes.
  #
  # The motorefi_paper_trail-association_tracking gem provides a related model,
  # `VersionAssociation`.
  class Version < ::ActiveRecord::Base
    include MotorefiPaperTrail::VersionConcern
  end
end
