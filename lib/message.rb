class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :posting

  scope :sent, -> { where ({:sent => true}) }
  scope :received, -> { where({:sent => false}) }

  define_method(:send_message) do | from, recipient |
    msg = self.dup
    msg.sent = false
    msg.user_id = recipient.id
    msg.save
    self.update_attributes :user_id => from.id, :sent => true
  end
end
