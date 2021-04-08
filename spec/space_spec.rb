require 'space'
require 'database_connection'

describe '.view_all_spaces' do

	it 'returns all spaces' do
		user = DatabaseConnection.query("INSERT INTO users (email, password) values ('test@test.com', 123) returning id;")

		DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) values ('First space', 'Great space', 100, #{user[0]['id']});")

		spaces = Space.view_all_spaces

		expect(spaces.length).to eq 1
		expect(spaces.first.name).to eq 'First space'
		expect(spaces.first.description).to eq 'Great space'
		expect(spaces.first.price.to_i).to eq 100
	end
end


# describe '.view_my_spaces' do

# 	it "returns a particular user's spaces" do
# 		user1 = DatabaseConnection.query("INSERT INTO users (name, password) values ('Bob', 123) returning id;")
# 		user2 = DatabaseConnection.query("INSERT INTO users (name, password) values ('Dylan', 124) returning id;")

# 		DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) values ('First space', 'Great space', 100, #{user1[0]['id']});")
# 		DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) values ('Second space', 'Great space', 100, #{user2[0]['id']});")
# 		DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) values ('Third space', 'Great space', 100, #{user1[0]['id']});")

# 		spaces = Space.view_my_spaces(user1)

# 		expect(spaces.length).to eq 2
# 		expect(spaces.first.name).to eq 'First space'
# 		expect(spaces.second.name).to eq 'Third space'
# 	end
# end