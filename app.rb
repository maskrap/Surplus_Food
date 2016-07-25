require "bundler/setup"
Bundler.require :default
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/postings/new' do
  erb(:posting_form.erb)
end
