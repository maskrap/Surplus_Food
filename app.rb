ENV['RACK_ENV'] = 'development'

require("bundler/setup")
require 'pry'

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

get '/' do
  erb :index
end

get '/postings' do
  @postings = Posting.all
  @categories = Category.all
  erb :postings
end

get '/new' do
  @categories = Category.all
  erb :posting_form
end

get '/postings/:id' do
  @posting = Posting.find(params["id"].to_i)
  erb :posting
end

delete '/postings/:id', :auth => :user do
  @posting = Posting.find(params["id"])
  @user = User.find(session[:user_id])
  if @user == @posting.user_id
    @posting.delete
  else
    flash[:notice] = "Only the original poster may delete the listing."
    redirect back
  end
  redirect :postings
end

post '/postings/form' do
  categories = Category.all
  user_id = session[:user_id]
  description = params['description']
  source_type = params['source_type']
  quantity = params['quantity']
  location = params['location']
  @posting = Posting.create({user_id: user_id, description: description, source_type: source_type, quantity: quantity, location: location})
  form_categories = params['category_name'].split(", ")
  if params['category_id'].to_i != nil && params['category_id'].to_i != 0
    selected_category = Category.find(params['category_id'].to_i)
    @posting.categories.push(selected_category)
    form_categories.each { |category|
      @posting.categories.push(Category.create({name: category}))
    }
  else
    form_categories.each { |category|
      @posting.categories.push(Category.create({name: category}))
    }
  end
  redirect '/postings'
end

get '/search' do
  @postings = Posting.all
  erb :search
end

get '/search/alphabetically/ascending' do
  @postings = Posting.order(description: :asc)
  @order = "descending"
  erb :search_results
end

get '/search/alphabetically/descending' do
  @postings = Posting.order(description: :desc)
  @order = "ascending"
  erb :search_results
end

get '/search/category' do
  @categories = Category.all
  @postings = Posting.all
  erb :categories
end

get '/search/locations' do
  @locations = ["North Portland", "Northeast Portland", "Northwest Portland", "Southeast Portland", "Southwest Portland"]
  @postings = Posting.all
  erb :locations
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
