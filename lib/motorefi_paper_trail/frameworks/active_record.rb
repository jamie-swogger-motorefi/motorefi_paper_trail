# frozen_string_literal: true

# Either ActiveRecord has already been loaded by the Lazy Load Hook in our
# Railtie, or else we load it now.
require "active_record"
::MotorefiPaperTrail::Compatibility.check_activerecord(::ActiveRecord.gem_version)

# Now we can load the parts of PT that depend on AR.
require "motorefi_paper_trail/has_motorefi_paper_trail"
require "motorefi_paper_trail/reifier"
require "motorefi_paper_trail/frameworks/active_record/models/motorefi_paper_trail/version"
ActiveRecord::Base.include MotorefiPaperTrail::Model
