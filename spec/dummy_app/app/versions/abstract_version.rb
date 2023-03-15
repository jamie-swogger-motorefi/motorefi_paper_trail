# frozen_string_literal: true

class AbstractVersion < ApplicationRecord
  include MotorefiPaperTrail::VersionConcern
  self.abstract_class = true
end
