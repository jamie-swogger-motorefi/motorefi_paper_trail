# frozen_string_literal: true

require "spec_helper"

module MotorefiPaperTrail
  ::RSpec.describe(Request, versioning: true) do
    describe ".enabled_for_model?" do
      it "returns true" do
        expect(MotorefiPaperTrail.request.enabled_for_model?(Widget)).to eq(true)
      end
    end

    describe ".disable_model" do
      after do
        MotorefiPaperTrail.request.enable_model(Widget)
      end

      it "sets enabled_for_model? to false" do
        expect(MotorefiPaperTrail.request.enabled_for_model?(Widget)).to eq(true)
        MotorefiPaperTrail.request.disable_model(Widget)
        expect(MotorefiPaperTrail.request.enabled_for_model?(Widget)).to eq(false)
      end
    end

    describe ".enabled_for_model" do
      after do
        MotorefiPaperTrail.request.enable_model(Widget)
      end

      it "sets enabled_for_model? to true" do
        MotorefiPaperTrail.request.enabled_for_model(Widget, false)
        expect(MotorefiPaperTrail.request.enabled_for_model?(Widget)).to eq(false)
        MotorefiPaperTrail.request.enabled_for_model(Widget, true)
        expect(MotorefiPaperTrail.request.enabled_for_model?(Widget)).to eq(true)
      end
    end

    describe ".enabled?" do
      it "returns true" do
        expect(MotorefiPaperTrail.request.enabled?).to eq(true)
      end
    end

    describe ".enabled=" do
      after do
        MotorefiPaperTrail.request.enabled = true
      end

      it "sets enabled? to true" do
        MotorefiPaperTrail.request.enabled = true
        expect(MotorefiPaperTrail.request.enabled?).to eq(true)
        MotorefiPaperTrail.request.enabled = false
        expect(MotorefiPaperTrail.request.enabled?).to eq(false)
      end
    end

    describe ".controller_info" do
      it "returns an empty hash" do
        expect(MotorefiPaperTrail.request.controller_info).to eq({})
      end
    end

    describe ".controller_info=" do
      after do
        MotorefiPaperTrail.request.controller_info = {}
      end

      it "sets controller_info" do
        MotorefiPaperTrail.request.controller_info = { foo: :bar }
        expect(MotorefiPaperTrail.request.controller_info).to eq(foo: :bar)
      end
    end

    describe ".enable_model" do
      after do
        MotorefiPaperTrail.request.enable_model(Widget)
      end

      it "sets enabled_for_model? to true" do
        MotorefiPaperTrail.request.disable_model(Widget)
        expect(MotorefiPaperTrail.request.enabled_for_model?(Widget)).to eq(false)
        MotorefiPaperTrail.request.enable_model(Widget)
        expect(MotorefiPaperTrail.request.enabled_for_model?(Widget)).to eq(true)
      end
    end

    describe ".whodunnit" do
      context "when set to a proc" do
        it "evaluates the proc each time a version is made" do
          call_count = 0
          described_class.whodunnit = proc { call_count += 1 }
          expect(described_class.whodunnit).to eq(1)
          expect(described_class.whodunnit).to eq(2)
        end
      end

      context "when set to a primtive value" do
        it "returns the primitive value" do
          described_class.whodunnit = :some_whodunnit
          expect(described_class.whodunnit).to eq(:some_whodunnit)
        end
      end
    end

    describe ".with" do
      context "with a block given" do
        context "with all allowed options" do
          it "sets options only for the block passed" do
            described_class.whodunnit = "some_whodunnit"
            described_class.enabled_for_model(Widget, true)

            described_class.with(whodunnit: "foo", enabled_for_Widget: false) do
              expect(described_class.whodunnit).to eq("foo")
              expect(described_class.enabled_for_model?(Widget)).to eq false
            end
            expect(described_class.whodunnit).to eq "some_whodunnit"
            expect(described_class.enabled_for_model?(Widget)).to eq true
          end

          it "sets options only for the current thread" do
            described_class.whodunnit = "some_whodunnit"
            described_class.enabled_for_model(Widget, true)

            described_class.with(whodunnit: "foo", enabled_for_Widget: false) do
              expect(described_class.whodunnit).to eq("foo")
              expect(described_class.enabled_for_model?(Widget)).to eq false
              Thread.new { expect(described_class.whodunnit).to be_nil }.join
              Thread.new { expect(described_class.enabled_for_model?(Widget)).to eq true }.join
            end
            expect(described_class.whodunnit).to eq "some_whodunnit"
            expect(described_class.enabled_for_model?(Widget)).to eq true
          end
        end

        context "with some invalid options" do
          it "raises an invalid option error" do
            subject = proc do
              described_class.with(whodunnit: "blah", invalid_option: "foo") do
                raise "This block should not be reached"
              end
            end

            expect { subject.call }.to raise_error(MotorefiPaperTrail::InvalidOption) do |e|
              expect(e.message).to eq "Invalid option: invalid_option"
            end
          end
        end

        context "with all invalid options" do
          it "raises an invalid option error" do
            subject = proc do
              described_class.with(invalid_option: "foo", other_invalid_option: "blah") do
                raise "This block should not be reached"
              end
            end

            expect { subject.call }.to raise_error(MotorefiPaperTrail::InvalidOption) do |e|
              expect(e.message).to eq "Invalid option: invalid_option"
            end
          end
        end
      end
    end
  end
end
