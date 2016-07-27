ENV['RACK_ENV'] = 'development'

require 'bundler/setup'
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
  @page = "home"
  @postings = Posting.take(4)
  erb :index
end

get '/aboutus' do
  erb :aboutus
end
get '/foodwaste' do
  erb :foodwaste
end

get '/what_you_can_do' do
  erb :what_you_can_do
end

get '/forgot' do
  erb :forgot
end

get '/postings' do
  @postings = Posting.all
  @categories = Category.all
  erb :postings
end

get '/new', :auth => :user do
  @categories = Category.all
  erb :posting_form
end

delete '/postings/:id', :auth => :user do
  @posting = Posting.find(params["id"])
  @user = User.find(session[:user_id])
  if @user == @posting.user
    @posting.delete
    Category.all.each { |category| category.postings.destroy(@posting) }
  else
    flash[:notice] = "Only the original poster may delete the listing."
    redirect back
  end
  redirect :postings
end

post '/postings/form', :auth => :user do
  user_id = session[:user_id]
  description = params['description']
  source_type = params['source_type']
  quantity = params['quantity']
  location = params['location']
  @posting = Posting.create({user_id: user_id, description: description, source_type: source_type, quantity: quantity, location: location})
  form_categories = params['category_name'].split(", ")
  form_categories.each { |category|
    new_cat = Category.create({name: category})
    if new_cat.save
      @posting.categories.push(new_cat)
    else
      @posting.categories.push(Category.where(name: category))
    end
  }
  redirect '/postings'
end

get '/postings/:id' do
  @posting = Posting.find(params[:id])
  erb :posting_details
end

post '/postings/:id/contact', :auth => :user do
  post = Posting.find(params[:id])
  new_message = post.messages.create({:subject => params[:title], :body => params[:body]})
  new_message.send_message(User.find(session[:user_id]), post.user)
  flash[:alert] = "Message Sent"
  redirect back
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

get '/user', :auth => :user  do
  @user = User.find(session[:user_id])
  erb :user
end

patch '/user/edit', :auth => :user do
  user = User.find(session[:user_id])
  if params[:password] == params[:password_confirm]
    user.update({:password => params[:password]})
    flash[:alert] = "Password successfully changed!"
    redirect to "/"
  else
    flash[:notice] = "Passwords do not match."
  end
  redirect to "/user"
end

post '/user/new' do
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
  @message = @user.messages.find(params[:id])
  erb :message
end

post '/inbox/:id', :auth => :user do
  msg = Message.find(params[:id])
  post = Posting.find(msg.posting.id)
  new_message = post.messages.create({:subject => params[:title], :body => params[:body]})
  new_message.send_message(User.find(session[:user_id]), msg.sender)
  redirect to '/inbox'
end

delete '/inbox/:id', :auth => :user do
  msg = Message.find(params[:id])
  msg.destroy ? flash[:alert] = "Message Deleted" : flash[:notice] = "Unable to delete message."
  redirect to "/inbox"
end

get '/logout' do
  session[:user_id] = nil
  redirect to '/'
end
