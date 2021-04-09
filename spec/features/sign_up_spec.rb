require_relative 'web_helpers'
feature 'Account access' do
  scenario 'User can sign up' do
    visit('/sign-up')
    sign_up
    expect(current_path).to eq '/list-space'
  end
  
  scenario 'Users can not sign up with credentials already been used' do
    visit('/sign-up')
    sign_up
    visit('/sign-up')
    fill_in :email, with: 'test@test.com'
    fill_in :password, with: 'pass'
    click_button 'Submit'
    expect(page).to have_content 'Credentials have already been used by another user.'
  end

  scenario 'User can Log in' do
    sign_up
    visit('/log-in')
    fill_in :email, with: 'test@test.com'
    fill_in :password, with: 'pass'
    click_button 'Log in'
    expect(current_path).to eq '/my-spaces'
  end

  scenario 'User can not log in with wrong credentials' do
    sign_up
    visit('/log-in')
    fill_in :email, with: 'wrong@test.com'
    fill_in :password, with: 'passs'
    click_button 'Log in'
    expect(page).to have_content 'Please check your email or password.'
  end
end
