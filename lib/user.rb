class User < ActiveRecord::Base
  has_many :messages
  has_many :postings
  has_secure_password
  validates :name, presence: true
end
