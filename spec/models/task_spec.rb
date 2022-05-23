require "rails_helper"

RSpec.describe Task, type: :model do
  subject {
    described_class.new(title: "Anything",
                        description: "Description")
  }

  it { should validate_length_of(:title).is_at_least(5).with_message("Title min 5 chars") }
  it { should validate_presence_of(:title).with_message("Title blank") }

  it { should validate_length_of(:description).is_at_least(10).with_message("Description min 10 chars") }
  it { should validate_presence_of(:description).with_message("Description blank") }

  context "before save" do
    it "with blank title" do
      subject.title = ""
      expect(subject).to_not be_valid
    end
    it "with short(< 5 chars) title" do
      subject.title = "t" * 4
      expect(subject).to_not be_valid
    end
    it "with correct title" do
      expect(subject).to be_valid
    end
    it "with blank description" do
      subject.description = ""
      expect(subject).to_not be_valid
    end
    it "with short(< 10 chars) description" do
      subject.description = "d" * 9
      expect(subject).to_not be_valid
    end
    it "with correct description" do
      expect(subject).to be_valid
    end
    it "with correct default status" do
      expect(subject.status).to eq("todo")
    end
  end
end
