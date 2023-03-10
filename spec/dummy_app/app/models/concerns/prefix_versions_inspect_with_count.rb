# frozen_string_literal: true

module PrefixVersionsInspectWithCount
  def inspect
    "#{length} motorefi_versions:\n" +
      super
  end
end
