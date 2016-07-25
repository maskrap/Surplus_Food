ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
Bundler.require(:default, :test)
set(:root, Dir.pwd())
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

require 'capybara/rspec'
require './app'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

RSpec.configure { |config|
  config.after(:each) {
    Posting.all.each { |posting|
      posting.destroy
    }
    Category.all.each { |category|
      category.destroy
    }
  }
}
