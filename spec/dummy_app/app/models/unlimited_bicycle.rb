# frozen_string_literal: true

class UnlimitedBicycle < Vehicle
  has_motorefi_paper_trail limit: nil
end
