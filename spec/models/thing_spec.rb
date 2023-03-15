# frozen_string_literal: true

require "spec_helper"

RSpec.describe Thing, type: :model do
  describe "#motorefi_versions", versioning: true do
    let(:thing) { described_class.create! }

    it "applies the scope option" do
      expect(described_class.reflect_on_association(:motorefi_versions).scope).to be_a Proc
      expect(thing.motorefi_versions.to_sql).to end_with "ORDER BY id desc"
    end

    it "applies the extend option" do
      expect(thing.motorefi_versions.singleton_class).to be < PrefixVersionsInspectWithCount
      expect(thing.motorefi_versions.inspect).to start_with("1 motorefi_versions:")
    end
  end
end
