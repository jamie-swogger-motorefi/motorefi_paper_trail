# frozen_string_literal: true

# Demonstrates a "custom motorefi_versions association name". Instead of the association
# being named `motorefi_versions`, it will be named `motorefi_paper_trail_versions`.
class Document < ApplicationRecord
  has_motorefi_paper_trail(
    motorefi_versions: { name: :motorefi_paper_trail_versions },
    on: %i[create update]
  )
end
