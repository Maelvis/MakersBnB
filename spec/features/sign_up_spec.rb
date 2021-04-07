
feature 'Account access' do
  #As a user,
  #I want to be able to sign up for MakersBnB
  #So that i can access services of the site
  scenario 'User can sign up' do
    visit('/sign-up')
    fill_in :email, with: 'rahat.ahmed1@outlook.com'
    fill_in :password, with: 'Password123'
    fill_in :confirm_password, with: 'Password123'
  end
  
  scenario 'User can Log in' do
    visit('/log-in')
    fill_in :email, with: 'rahat.ahmed1@outlook.com'
    fill_in :password, with: 'Password123'
  end
end
