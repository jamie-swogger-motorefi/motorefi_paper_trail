# frozen_string_literal: true

require "securerandom"
require "spec_helper"

module MotorefiPaperTrail
  ::RSpec.describe Config do
    describe ".instance" do
      it "returns the singleton instance" do
        expect { described_class.instance }.not_to raise_error
      end
    end

    describe ".new" do
      it "raises NoMethodError" do
        expect { described_class.new }.to raise_error(NoMethodError)
      end
    end

    describe ".version_limit", versioning: true do
      after { MotorefiPaperTrail.config.version_limit = nil }

      it "limits the number of motorefi_versions to 3 (2 plus the created at event)" do
        MotorefiPaperTrail.config.version_limit = 2
        widget = Widget.create!(name: "Henry")
        6.times { widget.update_attribute(:name, SecureRandom.hex(8)) }
        expect(widget.motorefi_versions.first.event).to(eq("create"))
        expect(widget.motorefi_versions.size).to(eq(3))
      end

      it "overrides the general limits to 4 (3 plus the created at event)" do
        MotorefiPaperTrail.config.version_limit = 100
        bike = LimitedBicycle.create!(name: "Limited Bike") # has_motorefi_paper_trail limit: 3
        10.times { bike.update_attribute(:name, SecureRandom.hex(8)) }
        expect(bike.motorefi_versions.first.event).to(eq("create"))
        expect(bike.motorefi_versions.size).to(eq(4))
      end

      it "overrides the general limits with unlimited motorefi_versions for model" do
        MotorefiPaperTrail.config.version_limit = 3
        bike = UnlimitedBicycle.create!(name: "Unlimited Bike") # has_motorefi_paper_trail limit: nil
        6.times { bike.update_attribute(:name, SecureRandom.hex(8)) }
        expect(bike.motorefi_versions.first.event).to(eq("create"))
        expect(bike.motorefi_versions.size).to eq(7)
      end

      it "is not enabled on non-papertrail STI base classes, but enabled on subclasses" do
        MotorefiPaperTrail.config.version_limit = 10
        Vehicle.create!(name: "A Vehicle", type: "Vehicle")
        limited_bike = LimitedBicycle.create!(name: "Limited")
        limited_bike.name = "A new name"
        limited_bike.save
        assert_equal 2, limited_bike.motorefi_versions.length
      end
    end
  end
end
