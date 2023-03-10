# frozen_string_literal: true

require "spec_helper"
require_dependency "on/create"

module On
  RSpec.describe Create, type: :model, versioning: true do
    describe "#motorefi_versions" do
      it "only have a version for the create event" do
        record = described_class.create(name: "Alice")
        record.update(name: "blah")
        record.destroy
        expect(record.motorefi_versions.length).to(eq(1))
        expect(record.motorefi_versions.last.event).to(eq("create"))
      end
    end

    describe "#motorefi_paper_trail_event" do
      it "rembembers the custom event name" do
        record = described_class.new
        record.motorefi_paper_trail_event = "banana"
        record.update(name: "blah")
        record.destroy
        expect(record.motorefi_versions.length).to(eq(1))
        expect(record.motorefi_versions.last.event).to(eq("banana"))
      end
    end

    describe "#touch" do
      it "does not create a version" do
        record = described_class.create(name: "Alice")
        expect { record.touch }.not_to(
          change { record.motorefi_versions.count }
        )
      end
    end
  end
end
