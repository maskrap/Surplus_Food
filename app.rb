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

get '/postings/new' do
  @categories = Category.all
  erb :posting_form
end

post '/postings/new' do
  categories = Category.all
  user_id = session[:user_id]
  description = params['description']
  source_type = params['source_type']
  quantity = params['quantity']
  location = params['location']
  @posting = Posting.create({user_id: user_id, description: description, source_type: source_type, quantity: quantity, location: location})
  selected_category = Category.find(params['category_id'].to_i)
  form_category = params['category_name']
  category = Category.create({name: form_category})
  if selected_category != nil
    @posting.categories.push(selected_category)
  else
    @posting.categories.push(category)
  end
  redirect '/postings'
end
