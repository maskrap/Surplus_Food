require 'spec_helper'

describe Message do
  it "sends messages" do
    user1 = User.create(:name => "Bob", :password => "test")
    message = Message.create(:subject => "Test Message", :body => "this is test body")
    user2 = User.create(:name => "Jane", :password => "test")
    message.send_message(user1, user2)
    expect(user1.messages).to(eq([message]))
    expect(Message.all.size).to(eq(2))
  end
end
