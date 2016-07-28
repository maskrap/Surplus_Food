ENV['RACK_ENV'] = 'test'
require 'bundler/setup'
Bundler.require(:default, :test)
set(:root, Dir.pwd())

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

require 'capybara/rspec'
require 'rack_session_access/capybara'
require './app'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :active_record
    with.library :active_model
  end
end

Sinatra::Application.configure do | app |
  app.use RackSessionAccess::Middleware
end

RSpec.configure { |config|
  config.after(:each) {
    Posting.all.each { |posting|
      posting.destroy
    }
    Category.all.each { |category|
      category.destroy
    }
    User.all().each do | item |
      item.destroy()
    end

    Message.all().each do | item |
      item.destroy()
    end
  }
}
