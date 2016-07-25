require 'spec_helper'

describe Category, type: :model do
  it { should have_and_belong_to_many :postings }

  it "converts name to title case" do
    test_category = Category.create({name: "dairy"})
    expect(test_category.name).to eq("Dairy")
  end
end
