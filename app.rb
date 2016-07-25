ENV['RACK_ENV'] = 'development'

require("bundler/setup")

Bundler.require(:default)

set :sessions => true
use Rack::Flash, :sweep => true

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file}

also_reload('lib/**/*.rb')

register do
  def auth(type)
    condition do
      redirect "/login" unless send("is_#{type}?")
    end
  end
end

helpers do
  def is_user?
    @user != nil
  end
end

before do
  @user = session[:user_id] ? User.find(session[:user_id]) : nil
end

get '/postings/new' do
  erb :posting_form
end
