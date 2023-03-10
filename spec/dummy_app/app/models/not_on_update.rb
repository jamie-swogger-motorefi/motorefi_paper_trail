# frozen_string_literal: true

# This model does not record motorefi_versions when updated.
class NotOnUpdate < ApplicationRecord
  has_motorefi_paper_trail on: %i[create destroy]
end
