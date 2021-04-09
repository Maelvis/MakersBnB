require 'space'
require 'database_connection'

describe '.view_all_spaces' do

	it 'returns all spaces' do
		user = DatabaseConnection.query("INSERT INTO users (email, password) values ('test@test.com', 123) returning id;")

		DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) values ('First space', 'Great space', '100', #{user[0]['id']});")
		DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) values ('Second space', 'Great space', '90', #{user[0]['id']});")

		spaces = Space.view_all_spaces

		expect(spaces.length).to eq 2
		expect(spaces.first.name).to eq 'First space'
		expect(spaces.last.name).to eq 'Second space'
		expect(spaces.first.description).to eq 'Great space'
		expect(spaces.first.price.to_i).to eq 100
	end
end


describe '.view_my_spaces' do

    it "returns a particular user's spaces" do
        user1 = DatabaseConnection.query("INSERT INTO users (email, password) values ('Bob', 123) returning id;")
        user2 = DatabaseConnection.query("INSERT INTO users (email, password) values ('Dylan', 124) returning id;")

        Space.create_space(name: 'Cotswolds', description: 'A cottage in the Cotswolds', price: 120, host_id: user1[0]['id'] )
        Space.create_space(name: 'Edinburgh', description: 'A farmhouse in Edinburgh', price: 120, host_id: user1[0]['id'] )
        Space.create_space(name: 'Blackpool', description: 'A beach hut in Blackpool', price: 120, host_id: user2[0]['id'] )

        spaces = Space.view_my_spaces(host_id: user1[0]['id'])
        expect(spaces.length).to eq 2
        expect(spaces.first.name).to eq 'Cotswolds'
		expect(spaces[1].name).to eq 'Edinburgh'
    end
end

describe '.view_my_spaces' do

    it "returns a particular user's spaces" do
        user1 = DatabaseConnection.query("INSERT INTO users (email, password) values ('Bob', 123) returning id;")
        user2 = DatabaseConnection.query("INSERT INTO users (email, password) values ('Dylan', 124) returning id;")

        Space.create_space(name: 'Cotswolds', description: 'A cottage in the Cotswolds', price: 120, host_id: user1[0]['id'] )
        Space.create_space(name: 'Edinburgh', description: 'A farmhouse in Edinburgh', price: 120, host_id: user1[0]['id'] )
        Space.create_space(name: 'Blackpool', description: 'A beach hut in Blackpool', price: 120, host_id: user2[0]['id'] )

        spaces = Space.view_my_spaces(host_id: user1[0]['id'])
        expect(spaces.length).to eq 2
        expect(spaces.first.name).to eq 'Cotswolds'
		expect(spaces[1].name).to eq 'Edinburgh'
    end
end
describe '.view_booking_requests' do

    it "returns a particular user's booked spaces" do
        user1 = DatabaseConnection.query("INSERT INTO users (email, password) values ('Bob', 123) returning id;")
        user2 = DatabaseConnection.query("INSERT INTO users (email, password) values ('Dylan', 124) returning id;")

        Space.create_space(name: 'Cotswolds', description: 'A cottage in the Cotswolds', price: 120, host_id: user1[0]['id'] )
        Space.create_space(name: 'Edinburgh', description: 'A farmhouse in Edinburgh', price: 120, host_id: user1[0]['id'] )
        blackpool = Space.create_space(name: 'Blackpool', description: 'A beach hut in Blackpool', price: 120, host_id: user2[0]['id'] )

		Booking.create(space_id: blackpool.id, guest_id: user1[0]['id'], host_id: user2[0]['id'],  start_date: '04/03/21', leave_date: '06/03/21' )
		DatabaseConnection.query("UPDATE bookings SET confirmed = FALSE WHERE host_id = #{user2[0]['id']};" )

        request = Space.view_booking_requests(host_id: user2[0]['id'])

        expect(request.first.name).to eq 'Blackpool'
		expect(request.length).to eq 1
		expect(request.first.host_id).to eq user2[0]['id']

		
    end
end


describe '.create_space' do

    it 'creates a new space' do
        user = DatabaseConnection.query("INSERT INTO users (email, password) values ('Bob', 123) returning id;")
        space = Space.create_space(name: 'Cotswolds', description: 'A cottage in the Cotswolds', price: 120, host_id: user[0]['id'] )
		
        expect(space.name).to eq 'Cotswolds'
        expect(space.description).to eq 'A cottage in the Cotswolds'
        expect(space.price.to_i).to eq 120
        expect(space.host_id).to eq user[0]['id']

    end
end
