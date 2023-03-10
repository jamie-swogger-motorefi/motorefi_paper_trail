# frozen_string_literal: true

require "spec_helper"

RSpec.describe Document, type: :model, versioning: true do
  describe "have_a_version_with matcher" do
    it "works with custom motorefi_versions association" do
      document = described_class.create!(name: "Foo")
      document.update!(name: "Bar")
      expect(document).to have_a_version_with(name: "Foo")
    end
  end

  describe "#motorefi_paper_trail.next_version" do
    it "returns the expected document" do
      doc = described_class.create
      doc.update(name: "Doc 1")
      reified = doc.motorefi_paper_trail_versions.last.reify
      expect(doc.name).to(eq(reified.motorefi_paper_trail.next_version.name))
    end
  end

  describe "#motorefi_paper_trail.previous_version" do
    it "returns the expected document" do
      doc = described_class.create
      doc.update(name: "Doc 1")
      doc.update(name: "Doc 2")
      expect(doc.motorefi_paper_trail_versions.length).to(eq(3))
      expect(doc.motorefi_paper_trail.previous_version.name).to(eq("Doc 1"))
    end
  end

  describe "#motorefi_paper_trail_versions" do
    it "returns the expected version records" do
      doc = described_class.create
      doc.update(name: "Doc 1")
      expect(doc.motorefi_paper_trail_versions.length).to(eq(2))
      expect(doc.motorefi_paper_trail_versions.map(&:event)).to(
        match_array(%w[create update])
      )
    end
  end

  describe "#motorefi_versions" do
    it "does not respond to motorefi_versions method" do
      doc = described_class.create
      doc.update(name: "Doc 1")
      expect(doc).not_to respond_to(:motorefi_versions)
    end
  end
end
