class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :posting
  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"

  scope :sent, -> { where ({:sent => true}) }
  scope :received, -> { where({:sent => false}) }

  define_method(:send_message) do | from, recipient |
    msg = self.dup
    msg.sent = false
    msg.sender_id = from.id
    msg.receiver_id = recipient.id
    msg.user_id = recipient.id
    msg.save
    self.update_attributes :user_id => from.id,
                           :sent => true,
                           :receiver_id => recipient.id,
                           :sender_id => from.id
  end
end
