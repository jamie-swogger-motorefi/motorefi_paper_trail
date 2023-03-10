# frozen_string_literal: true

class Post < ApplicationRecord
  has_motorefi_paper_trail motorefi_versions: { class_name: "PostVersion" }
end
