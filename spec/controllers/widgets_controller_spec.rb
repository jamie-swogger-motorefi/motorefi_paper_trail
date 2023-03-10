# frozen_string_literal: true

require "spec_helper"

RSpec.describe WidgetsController, type: :controller, versioning: true do
  before { request.env["REMOTE_ADDR"] = "127.0.0.1" }

  after { RequestStore.store[:motorefi_paper_trail] = nil }

  describe "#create" do
    context "with PT enabled" do
      it "stores information like IP address in version" do
        post(:create, params: { widget: { name: "Flugel" } })
        widget = assigns(:widget)
        expect(widget.motorefi_versions.length).to(eq(1))
        expect(widget.motorefi_versions.last.whodunnit.to_i).to(eq(153))
        expect(widget.motorefi_versions.last.ip).to(eq("127.0.0.1"))
        expect(widget.motorefi_versions.last.user_agent).to(eq("Rails Testing"))
      end

      it "controller metadata methods should get evaluated" do
        request.env["HTTP_USER_AGENT"] = "User-Agent"
        post :create, params: { widget: { name: "Flugel" } }
        expect(MotorefiPaperTrail.request.enabled?).to eq(true)
        expect(MotorefiPaperTrail.request.whodunnit).to(eq(153))
        expect(MotorefiPaperTrail.request.controller_info.present?).to(eq(true))
        expect(MotorefiPaperTrail.request.controller_info.key?(:ip)).to(eq(true))
        expect(MotorefiPaperTrail.request.controller_info.key?(:user_agent)).to(eq(true))
      end
    end

    context "with PT disabled" do
      it "does not save a version, and metadata is not set" do
        request.env["HTTP_USER_AGENT"] = "Disable User-Agent"
        post :create, params: { widget: { name: "Flugel" } }
        expect(assigns(:widget).motorefi_versions.length).to(eq(0))
        expect(MotorefiPaperTrail.request.enabled?).to eq(false)
        expect(MotorefiPaperTrail.request.whodunnit).to be_nil
        expect(MotorefiPaperTrail.request.controller_info).to eq({})
      end
    end
  end

  describe "#destroy" do
    it "can be disabled" do
      request.env["HTTP_USER_AGENT"] = "Disable User-Agent"
      post(:create, params: { widget: { name: "Flugel" } })
      w = assigns(:widget)
      expect(w.motorefi_versions.length).to(eq(0))
      delete(:destroy, params: { id: w.id })
      expect(MotorefiPaperTrail::Version.with_item_keys("Widget", w.id).size).to(eq(0))
    end

    it "stores information like IP address in version" do
      w = Widget.create(name: "Roundel")
      expect(w.motorefi_versions.length).to(eq(1))
      delete(:destroy, params: { id: w.id })
      widget = assigns(:widget)
      expect(widget.motorefi_versions.length).to(eq(2))
      expect(widget.motorefi_versions.last.ip).to(eq("127.0.0.1"))
      expect(widget.motorefi_versions.last.user_agent).to(eq("Rails Testing"))
      expect(widget.motorefi_versions.last.whodunnit.to_i).to(eq(153))
    end
  end

  describe "#update" do
    it "stores information like IP address in version" do
      w = Widget.create(name: "Duvel")
      expect(w.motorefi_versions.length).to(eq(1))
      put(:update, params: { id: w.id, widget: { name: "Bugle" } })
      widget = assigns(:widget)
      expect(widget.motorefi_versions.length).to(eq(2))
      expect(widget.motorefi_versions.last.whodunnit.to_i).to(eq(153))
      expect(widget.motorefi_versions.last.ip).to(eq("127.0.0.1"))
      expect(widget.motorefi_versions.last.user_agent).to(eq("Rails Testing"))
    end

    it "can be disabled" do
      request.env["HTTP_USER_AGENT"] = "Disable User-Agent"
      post(:create, params: { widget: { name: "Flugel" } })
      w = assigns(:widget)
      expect(w.motorefi_versions.length).to(eq(0))
      put(:update, params: { id: w.id, widget: { name: "Bugle" } })
      widget = assigns(:widget)
      expect(widget.motorefi_versions.length).to(eq(0))
    end
  end
end
