# frozen_string_literal: true

class LimitedBicycle < Vehicle
  has_motorefi_paper_trail limit: 3
end
