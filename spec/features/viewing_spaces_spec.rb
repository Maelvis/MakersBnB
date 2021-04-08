feature 'View spaces' do
  scenario 'User can view all spaces' do
    user = DatabaseConnection.query("INSERT INTO users (email, password) values ('test@test.com', 123) returning id;")

		DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) values ('First space', 'Great space', 100, #{user[0]['id']});")

		spaces = Space.view_all_spaces
    
    visit('/all-spaces')
    expect(page).to have_content "Nothing to view"
  end
end