# frozen_string_literal: true

require "spec_helper"

RSpec.describe PostWithStatus, type: :model do
  with_versioning do
    let(:post) { described_class.create!(status: "draft") }

    it "saves the enum value in motorefi_versions" do
      post.published!
      post.archived!
      expect(post.motorefi_paper_trail.previous_version.published?).to be true
    end

    it "can read enums in version records written by PT 4" do
      post = described_class.create(status: "draft")
      post.published!
      version = post.motorefi_versions.last
      # Simulate behavior PT 4, which used to save the string version of
      # enums to `object_changes`
      version.update(object_changes: "---\nid:\n- \n- 1\nstatus:\n- draft\n- published\n")
      assert_equal %w[draft published], version.changeset["status"]
    end

    context "when storing enum object_changes" do
      it "saves the enum value properly in motorefi_versions object_changes" do
        post.published!
        post.archived!
        post_version = post.motorefi_versions.last
        expect(post_version.changeset["status"]).to eql(%w[published archived])
      end
    end

    describe "#save_with_version" do
      context "when passing *args" do
        it "passes *args down correctly" do
          post = described_class.create(status: :draft)
          expect do
            post.motorefi_paper_trail.save_with_version(validate: false)
          end.to change(post.motorefi_versions, :count).by(1)
        end
      end

      it "preserves the enum value (and all other attributes)" do
        post = described_class.create(status: :draft)
        expect(post.motorefi_versions.count).to eq(1)
        expect(post.status).to eq("draft")
        post.motorefi_paper_trail.save_with_version
        expect(post.motorefi_versions.count).to eq(2)
        expect(post.motorefi_versions.last[:object]).to include("status: 0")
        expect(post.motorefi_paper_trail.previous_version.status).to eq("draft")
      end
    end
  end
end
