# frozen_string_literal: true

class Animal < ApplicationRecord
  has_motorefi_paper_trail
  self.inheritance_column = "species"
end
