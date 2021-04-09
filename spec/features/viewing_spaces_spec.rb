require 'database_connection'
require './lib/database_connection_setup'
require_relative 'web_helpers'
feature 'View spaces' do
  scenario 'User can view all spaces' do
    sign_up
    list_space
    list_space_2
    visit('/all-spaces')
    expect(page).to have_content 'Test Space'
    expect(page).to have_content 'Test 2 Space'
  end
  
  scenario 'User can list space' do
    sign_up
    list_space
    expect(current_path).to eq '/my-spaces'
  end

  scenario 'User can see his spaces' do
    sign_up
    list_space
    visit('/my-spaces')
    expect(page).to have_content 'Test Space'
  end


end