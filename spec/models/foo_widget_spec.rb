# frozen_string_literal: true

require "spec_helper"
require "support/performance_helpers"

RSpec.describe(FooWidget, versioning: true) do
  context "with a subclass" do
    let(:foo) { described_class.create }

    before do
      foo.update!(name: "Foo")
    end

    it "reify with the correct type" do
      expect(MotorefiPaperTrail::Version.last.previous).to(eq(foo.motorefi_versions.first))
      expect(MotorefiPaperTrail::Version.last.next).to(be_nil)
    end

    it "returns the correct originator" do
      MotorefiPaperTrail.request.whodunnit = "Ben"
      foo.update_attribute(:name, "Geoffrey")
      expect(foo.motorefi_paper_trail.originator).to(eq(MotorefiPaperTrail.request.whodunnit))
    end

    context "when destroyed" do
      before { foo.destroy }

      it "reify with the correct type" do
        assert_kind_of(described_class, foo.motorefi_versions.last.reify)
        expect(MotorefiPaperTrail::Version.last.previous).to(eq(foo.motorefi_versions[1]))
        expect(MotorefiPaperTrail::Version.last.next).to(be_nil)
      end
    end
  end
end
