# frozen_string_literal: true

require "spec_helper"
require_dependency "on/destroy"

module On
  RSpec.describe Destroy, type: :model, versioning: true do
    describe "#motorefi_versions" do
      it "only creates one version record, for the destroy event" do
        record = described_class.create(name: "Alice")
        record.update(name: "blah")
        record.destroy
        expect(record.motorefi_versions.length).to(eq(1))
        expect(record.motorefi_versions.last.event).to(eq("destroy"))
      end
    end

    describe "#motorefi_paper_trail_event" do
      it "rembembers the custom event name" do
        record = described_class.create(name: "Alice")
        record.motorefi_paper_trail_event = "banana"
        record.update(name: "blah")
        record.destroy
        expect(record.motorefi_versions.length).to(eq(1))
        expect(record.motorefi_versions.last.event).to(eq("banana"))
      end
    end
  end
end
