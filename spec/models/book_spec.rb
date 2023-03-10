# frozen_string_literal: true

require "spec_helper"

RSpec.describe Book, versioning: true do
  context "with :has_many :through" do
    it "store version on source <<" do
      book = described_class.create(title: "War and Peace")
      dostoyevsky = Person.create(name: "Dostoyevsky")
      Person.create(name: "Solzhenitsyn")
      count = MotorefiPaperTrail::Version.count
      (book.authors << dostoyevsky)
      expect((MotorefiPaperTrail::Version.count - count)).to(eq(1))
      expect(book.authorships.first.motorefi_versions.first).to(eq(MotorefiPaperTrail::Version.last))
    end

    it "store version on source create" do
      book = described_class.create(title: "War and Peace")
      Person.create(name: "Dostoyevsky")
      Person.create(name: "Solzhenitsyn")
      count = MotorefiPaperTrail::Version.count
      book.authors.create(name: "Tolstoy")
      expect((MotorefiPaperTrail::Version.count - count)).to(eq(2))
      expect(
        [MotorefiPaperTrail::Version.order(:id).to_a[-2].item, MotorefiPaperTrail::Version.last.item]
      ).to match_array([Person.last, Authorship.last])
    end

    it "store version on join destroy" do
      book = described_class.create(title: "War and Peace")
      dostoyevsky = Person.create(name: "Dostoyevsky")
      Person.create(name: "Solzhenitsyn")
      (book.authors << dostoyevsky)
      count = MotorefiPaperTrail::Version.count
      book.authorships.reload.last.destroy
      expect((MotorefiPaperTrail::Version.count - count)).to(eq(1))
      expect(MotorefiPaperTrail::Version.last.reify.book).to(eq(book))
      expect(MotorefiPaperTrail::Version.last.reify.author).to(eq(dostoyevsky))
    end

    it "store version on join clear" do
      book = described_class.create(title: "War and Peace")
      dostoyevsky = Person.create(name: "Dostoyevsky")
      Person.create(name: "Solzhenitsyn")
      book.authors << dostoyevsky
      count = MotorefiPaperTrail::Version.count
      book.authorships.reload.destroy_all
      expect((MotorefiPaperTrail::Version.count - count)).to(eq(1))
      expect(MotorefiPaperTrail::Version.last.reify.book).to(eq(book))
      expect(MotorefiPaperTrail::Version.last.reify.author).to(eq(dostoyevsky))
    end
  end

  context "when a persisted record is updated then destroyed" do
    it "has changes" do
      book = described_class.create! title: "A"
      changes = YAML.load book.motorefi_versions.last.attributes["object_changes"]
      expect(changes).to eq("id" => [nil, book.id], "title" => [nil, "A"])

      book.update! title: "B"
      changes = YAML.load book.motorefi_versions.last.attributes["object_changes"]
      expect(changes).to eq("title" => %w[A B])

      book.destroy
      changes = YAML.load book.motorefi_versions.last.attributes["object_changes"]
      expect(changes).to eq("id" => [book.id, nil], "title" => ["B", nil])
    end
  end
end
