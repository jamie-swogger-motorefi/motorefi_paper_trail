# frozen_string_literal: true

require "spec_helper"
require "support/custom_json_serializer"

RSpec.describe Boolit, type: :model, versioning: true do
  let(:boolit) { described_class.create! }

  before { boolit.update!(name: FFaker::Name.name) }

  it "has two motorefi_versions" do
    expect(boolit.motorefi_versions.size).to eq(2)
  end

  it "can be reified and persisted" do
    expect { boolit.motorefi_versions.last.reify.save! }.not_to raise_error
  end

  context "when Instance falls out of default scope" do
    before { boolit.update!(scoped: false) }

    it "is NOT scoped" do
      expect(described_class.first).to be_nil
    end

    it "still can be reified and persisted" do
      expect { boolit.motorefi_paper_trail.previous_version.save! }.not_to raise_error
    end

    context "with `nil` attributes on the live instance" do
      before do
        MotorefiPaperTrail.serializer = CustomJsonSerializer
        boolit.update!(name: nil)
        boolit.update!(name: FFaker::Name.name)
      end

      after { MotorefiPaperTrail.serializer = MotorefiPaperTrail::Serializers::YAML }

      it "does not overwrite that attribute during the reification process" do
        expect(boolit.motorefi_paper_trail.previous_version.name).to be_nil
      end
    end
  end
end
