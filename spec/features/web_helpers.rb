def sign_up
  visit('/sign-up')
  fill_in :email, with: 'test@test.com'
  fill_in :password, with: 'pass'
  click_button 'Submit'
end

def list_space
  visit('/list-space')
  fill_in :name, with: 'Test Space'
  fill_in :description, with: 'Good'
  fill_in :price, with: '100'
  click_button 'Submit'
end

def list_space_2
  visit('/list-space')
  fill_in :name, with: 'Test 2 Space'
  fill_in :description, with: 'Bad'
  fill_in :price, with: '10'
  click_button 'Submit'
end

