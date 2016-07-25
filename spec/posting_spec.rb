require 'spec_helper'

describe Posting, type: :model do
  it { should have_and_belong_to_many :categories }

  it "validates presence of description" do
    test_posting = Posting.create({description: ""})
    expect(test_posting.save).to eq(false)
  end

  it "validates the presence of source type" do
    test_posting = Posting.create({source_type: ""})
    expect(test_posting.save).to eq(false)
  end

  it "validates the presence of quantity" do
    test_posting = Posting.create({quantity: ""})
    expect(test_posting.save).to eq(false)
  end

  it "validates the presence of location" do
    test_posting = Posting.create({location: ""})
    expect(test_posting.save).to eq(false)
  end

  it "converts the description to capital case" do
    posting = Posting.create({description: "artichoke", source_type: "farm", quantity: 5, location: "humboldt"})
    expect(posting.description).to eq("Artichoke")
  end
end
