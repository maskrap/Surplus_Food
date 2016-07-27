require 'spec_helper'

describe 'the surplus food path', type: :feature do
  it 'goes to the surplus food page' do
    visit '/'
    click_link("Login")
    expect(page).to have_content 'Please sign in'
  end

  it 'creates posting' do
    visit '/'
    click_link 'Login'
    new_user = User.create({:name => "Peter", :password => "Pan"})
    page.set_rack_session(user_id: new_user.id)
    visit '/'
    click_link 'add new posting'
    test_posting = Posting.new({:description => "description"})
    test_posting.save
    fill_in 'description', {:with => "Strawbs"}
    fill_in 'category_name', {:with => "Fruit"}
    select 'Individual', :from => "source_type"
    fill_in 'quantity', {:with => "1 bushel"}
    select 'Northeast Portland', :from => "location"
    click_button 'Add'
    expect(page).to have_content('Strawbs')
  end

end
