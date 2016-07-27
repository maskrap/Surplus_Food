class User < ActiveRecord::Base
  has_many :messages
  has_many :postings
  has_secure_password
  validates :name, presence: true
  before_save :downcase_name

private
  def downcase_name
    self.name=(name.downcase)
  end
end
