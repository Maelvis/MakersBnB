feature 'View spaces' do
  scenario 'User can view all spaces' do
    visit('/all-spaces')
    expect(page).to have_content "Nothing to view"
  end
end