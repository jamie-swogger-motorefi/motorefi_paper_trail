# frozen_string_literal: true

# See also `Fruit` which uses `JsonVersion`.
class Vegetable < ApplicationRecord
  has_motorefi_paper_trail motorefi_versions: {
    class_name: ENV["DB"] == "postgres" ? "JsonbVersion" : "MotorefiPaperTrail::Version"
  }, on: %i[create update]
end
