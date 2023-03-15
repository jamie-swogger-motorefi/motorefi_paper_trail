# frozen_string_literal: true

require "spec_helper"

::RSpec.describe(::Song, type: :model, versioning: true) do
  describe "#joins" do
    it "works" do
      described_class.create!
      result = described_class.
        joins(:motorefi_versions).
        select("songs.id, max(motorefi_versions.event) as event").
        group("songs.id").
        first
      expect(result.event).to eq("create")
    end
  end

  context "when the default accessor, length=, is overwritten" do
    it "returns overwritten value on reified instance" do
      song = Song.create(length: 4)
      song.update(length: 5)
      expect(song.length).to(eq(5))
      expect(song.motorefi_versions.last.reify.length).to(eq(4))
    end
  end

  context "when song name is a virtual attribute (no such db column)" do
    it "returns overwritten virtual attribute on the reified instance" do
      song = Song.create(length: 4)
      song.update(length: 5)
      song.name = "Good Vibrations"
      song.save
      song.name = "Yellow Submarine"
      expect(song.name).to(eq("Yellow Submarine"))
      expect(song.motorefi_versions.last.reify.name).to(eq("Good Vibrations"))
    end
  end
end
