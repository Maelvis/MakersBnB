require 'space'
require 'database_connection'

describe '.view_all_spaces' do

	it 'returns all spaces' do
		user = DatabaseConnection.query("INSERT INTO users (email, password) values ('test@test.com', 123) returning id;")

		DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) values ('First space', 'Great space', '100', #{user[0]['id']});")
		DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) values ('Second space', 'Great space', '90', #{user[0]['id']});")

		p spaces = Space.view_all_spaces

		expect(spaces.length).to eq 2
		expect(spaces.first.name).to eq 'First space'
		expect(spaces.last.name).to eq 'Second space'
		expect(spaces.first.description).to eq 'Great space'
		expect(spaces.first.price.to_i).to eq 100
	end
end


# describe '.view_my_spaces' do

# 	it "returns a particular user's spaces" do
# 		user1 = DatabaseConnection.query("INSERT INTO users (email, password) values ('Bob@bob.com', 123) returning id;")
# 		user2 = DatabaseConnection.query("INSERT INTO users (email, password) values ('Dylan@dylan.com', 124) returning id;")

# 		DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) values ('First space', 'Great space', '100', #{user[0]['id']});")
# 		DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) values ('Second space', 'Great space', '90', #{user[0]['id']});")
# 		DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) values ('Third space', 'Great space', 100, #{user1[0]['id']});")

# 		spaces = Space.view_my_spaces(user1)

# 		expect(spaces.length).to eq 2
# 		expect(spaces.first.name).to eq 'First space'
# 		expect(spaces.last.name).to eq 'Third space'
# 	end
# end
