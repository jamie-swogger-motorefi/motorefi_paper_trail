# frozen_string_literal: true

module On
  class Create < ApplicationRecord
    self.table_name = :on_create
    has_motorefi_paper_trail on: [:create]
  end
end
