# frozen_string_literal: true

class Thing < ApplicationRecord
  has_motorefi_paper_trail motorefi_versions: {
    scope: -> { order("id desc") },
    extend: PrefixVersionsInspectWithCount
  }
  belongs_to :person, optional: true
end
