# frozen_string_literal: true

require "rspec/core"
require "rspec/matchers"
require "motorefi_paper_trail/frameworks/rspec/helpers"

RSpec.configure do |config|
  config.include ::MotorefiPaperTrail::RSpec::Helpers::InstanceMethods
  config.extend ::MotorefiPaperTrail::RSpec::Helpers::ClassMethods

  config.before(:each) do
    ::MotorefiPaperTrail.enabled = false
    ::MotorefiPaperTrail.request.enabled = true
    ::MotorefiPaperTrail.request.whodunnit = nil
    ::MotorefiPaperTrail.request.controller_info = {} if defined?(::Rails) && defined?(::RSpec::Rails)
  end

  config.before(:each, versioning: true) do
    ::MotorefiPaperTrail.enabled = true
  end
end

RSpec::Matchers.define :be_versioned do
  # check to see if the model has `has_motorefi_paper_trail` declared on it
  match { |actual| actual.is_a?(::MotorefiPaperTrail::Model::InstanceMethods) }
end

RSpec::Matchers.define :have_a_version_with do |attributes|
  # check if the model has a version with the specified attributes
  match do |actual|
    versions_association = actual.class.versions_association_name
    actual.send(versions_association).where_object(attributes).any?
  end
end

RSpec::Matchers.define :have_a_version_with_changes do |attributes|
  # check if the model has a version changes with the specified attributes
  match do |actual|
    versions_association = actual.class.versions_association_name
    actual.send(versions_association).where_object_changes(attributes).any?
  end
end
