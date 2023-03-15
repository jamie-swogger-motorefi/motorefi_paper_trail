# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :chapter
  has_many :paragraphs, dependent: :destroy

  has_motorefi_paper_trail
end
