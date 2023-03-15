# frozen_string_literal: true

module Kitchen
  class Banana < ApplicationRecord
    has_motorefi_paper_trail motorefi_versions: { class_name: "Kitchen::BananaVersion" }
  end
end
