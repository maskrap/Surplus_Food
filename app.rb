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

get "/" do
  erb :index
end

get '/postings/new', :auth => :user do
  erb(:posting_form)
end


get '/login' do
 erb :login
end

post '/login' do
  user = params[:username]
  pw = params[:password]
  new_user = User.find_by(name: user)
  if new_user.try(:authenticate, pw)
    session[:user_id] = new_user.id
    redirect to '/'
  else
    flash[:notice] = "Invalid username or password"
    redirect back
  end
end

get '/signup' do
  erb :signup
end

get '/users', :auth => :user  do
  @user = User.find(session[:user_id])
  erb :user
end

post '/users/new' do
  new_user = User.new(name: params[:email], password: params[:password])
  if new_user.save
    session[:user_id] = new_user.id
    redirect to "/"
  else
    flash[:notice] = "Error creating account. Please check your input."
    redirect back
  end
end

get '/inbox', :auth => :user do
  @user = User.find(session[:user_id])
  erb :inbox
end

get '/inbox/:id', :auth => :user do
  @user = User.find(session[:user_id])
  @message = @users.messages.find_one(params[:id])
  erb :message
end

get '/logout' do
  session[:user_id] = nil
  redirect to '/'
end
