# frozen_string_literal: true

require "spec_helper"

RSpec.describe CallbackModifier, type: :model, versioning: true do
  describe "motorefi_paper_trail_on_destroy" do
    it "adds :destroy to motorefi_paper_trail_options[:on]" do
      modifier = NoArgDestroyModifier.create!(some_content: FFaker::Lorem.sentence)
      expect(modifier.motorefi_paper_trail_options[:on]).to eq([:destroy])
    end

    context "when :before" do
      it "creates the version before destroy" do
        modifier = BeforeDestroyModifier.create!(some_content: FFaker::Lorem.sentence)
        modifier.test_destroy
        expect(modifier.motorefi_versions.last.reify).not_to be_flagged_deleted
      end
    end

    unless ActiveRecord::Base.belongs_to_required_by_default
      context "when :after" do
        it "creates the version after destroy" do
          modifier = AfterDestroyModifier.create!(some_content: FFaker::Lorem.sentence)
          modifier.test_destroy
          expect(modifier.motorefi_versions.last.reify).to be_flagged_deleted
        end
      end
    end

    context "when no argument" do
      it "defaults to before destroy" do
        modifier = NoArgDestroyModifier.create!(some_content: FFaker::Lorem.sentence)
        modifier.test_destroy
        expect(modifier.motorefi_versions.last.reify).not_to be_flagged_deleted
      end
    end
  end

  describe "motorefi_paper_trail_on_update" do
    it "adds :update to motorefi_paper_trail_options[:on]" do
      modifier = UpdateModifier.create!(some_content: FFaker::Lorem.sentence)
      expect(modifier.motorefi_paper_trail_options[:on]).to eq [:update]
    end

    it "creates a version" do
      modifier = UpdateModifier.create!(some_content: FFaker::Lorem.sentence)
      modifier.update! some_content: "modified"
      expect(modifier.motorefi_versions.last.event).to eq "update"
    end
  end

  describe "motorefi_paper_trail_on_create" do
    it "adds :create to motorefi_paper_trail_options[:on]" do
      modifier = CreateModifier.create!(some_content: FFaker::Lorem.sentence)
      expect(modifier.motorefi_paper_trail_options[:on]).to eq [:create]
    end

    it "creates a version" do
      modifier = CreateModifier.create!(some_content: FFaker::Lorem.sentence)
      expect(modifier.motorefi_versions.last.event).to eq "create"
    end
  end

  context "when no callback-method used" do
    it "sets motorefi_paper_trail_options[:on] to [:create, :update, :destroy]" do
      modifier = DefaultModifier.create!(some_content: FFaker::Lorem.sentence)
      expect(modifier.motorefi_paper_trail_options[:on]).to eq %i[create update destroy touch]
    end

    it "tracks destroy" do
      modifier = DefaultModifier.create!(some_content: FFaker::Lorem.sentence)
      modifier.destroy
      expect(modifier.motorefi_versions.last.event).to eq "destroy"
    end

    it "tracks update" do
      modifier = DefaultModifier.create!(some_content: FFaker::Lorem.sentence)
      modifier.update! some_content: "modified"
      expect(modifier.motorefi_versions.last.event).to eq "update"
    end

    it "tracks create" do
      modifier = DefaultModifier.create!(some_content: FFaker::Lorem.sentence)
      expect(modifier.motorefi_versions.last.event).to eq "create"
    end
  end

  context "when only one callback-method" do
    it "does only track the corresponding event" do
      modifier = CreateModifier.create!(some_content: FFaker::Lorem.sentence)
      modifier.update!(some_content: "modified")
      modifier.test_destroy
      expect(modifier.motorefi_versions.collect(&:event)).to eq ["create"]
    end
  end
end
