ENV['RACK_ENV'] = 'test'

require('bundler/setup')
Bundler.require(:default, :test)
set(:root, Dir.pwd())

require('capybara/rspec')
require "rack_session_access/capybara"

Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, browser: :chrome)
# end
#
# Capybara.default_driver = :selenium

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

Sinatra::Application.configure do | app |
  app.use RackSessionAccess::Middleware
end

RSpec.configure do | config |
  config.after(:each) do
    User.all().each do | item |
      item.destroy()
    end

    Message.all().each do | item |
      item.destroy()
    end
  end
end
