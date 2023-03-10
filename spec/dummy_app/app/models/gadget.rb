# frozen_string_literal: true

class Gadget < ApplicationRecord
  has_motorefi_paper_trail ignore: [:brand, { color: proc { |obj| obj.color == "Yellow" } }]
end
