require 'spec_helper'

describe User do
  describe '#create' do
    it 'validates a new user is created with a secure password' do
      user = User.create({:name => "johndoe", :password => "password"})
      expect(user.authenticate('password')).to(eq(user))
    end
  end
end
