# frozen_string_literal: true

class Citation < ApplicationRecord
  belongs_to :quotation

  has_motorefi_paper_trail
end
