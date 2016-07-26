class Posting < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :messages
  before_save :capitalize_description
  validates :description, :source_type, :quantity, :location, :presence => true

private
  def capitalize_description
    self.description=(description.capitalize)
  end
end
