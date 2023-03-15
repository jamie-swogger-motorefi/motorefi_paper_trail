# frozen_string_literal: true

require "spec_helper"

RSpec.describe ArticlesController, type: :controller do
  describe "MotorefiPaperTrail.request.enabled?" do
    context "when MotorefiPaperTrail.enabled? == true" do
      before { MotorefiPaperTrail.enabled = true }

      after { MotorefiPaperTrail.enabled = false }

      it "returns true" do
        expect(MotorefiPaperTrail.enabled?).to eq(true)
        post :create, params: { article: { title: "Doh", content: FFaker::Lorem.sentence } }
        expect(assigns(:article)).not_to be_nil
        expect(MotorefiPaperTrail.request.enabled?).to eq(true)
        expect(assigns(:article).motorefi_versions.length).to eq(1)
      end
    end

    context "when MotorefiPaperTrail.enabled? == false" do
      it "returns false" do
        expect(MotorefiPaperTrail.enabled?).to eq(false)
        post :create, params: { article: { title: "Doh", content: FFaker::Lorem.sentence } }
        expect(MotorefiPaperTrail.request.enabled?).to eq(false)
        expect(assigns(:article).motorefi_versions.length).to eq(0)
      end
    end
  end
end
