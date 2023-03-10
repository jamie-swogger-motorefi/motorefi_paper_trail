# frozen_string_literal: true

# to demonstrate a has_through association that does not have motorefi_paper_trail enabled
class Editor < ApplicationRecord
  has_many :editorships, dependent: :destroy
end
