# frozen_string_literal: true

class Boolit < ApplicationRecord
  default_scope { where(scoped: true) }
  has_motorefi_paper_trail
end
