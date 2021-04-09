require 'booking'
require 'database_connection'
require 'space'

describe '.create' do

    it 'creates a new booking' do
        guest = DatabaseConnection.query("INSERT INTO users (email, password) values ('Bob', 123) returning id;")
        host = DatabaseConnection.query("INSERT INTO users (email, password) values ('Dylan', 124) returning id;")
        space = DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) VALUES ('Cotswolds', 'A cottage in the Cotswolds', 120, #{host[0]['id']}) returning id" )
        booking = Booking.create(space_id: space[0]['id'], guest_id: guest[0]['id'], host_id: host[0]['id'], start_date: '04/03/21', leave_date: '06/03/21')

        expect(booking.space_id).to eq space[0]['id']
        expect(booking.guest_id).to eq guest[0]['id']
        expect(booking.host_id).to eq host[0]['id']
        expect(booking.start_date).to eq ('2021-04-03')
        expect(booking.leave_date).to eq ('2021-06-03')

    end
    
end

describe 'confirm' do
    it 'confirms a booking' do
        guest = DatabaseConnection.query("INSERT INTO users (email, password) values ('Bob', 123) returning id;")
        host = DatabaseConnection.query("INSERT INTO users (email, password) values ('Dylan', 124) returning id;")
        space = DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) VALUES ('Cotswolds', 'A cottage in the Cotswolds', 120, #{host[0]['id']}) returning id" )
        booking = Booking.create(space_id: space[0]['id'], guest_id: guest[0]['id'], host_id: host[0]['id'], start_date: '04/03/21', leave_date: '06/03/21')
        Booking.confirm(booking_id: booking.id)
        expect(booking.confirmed).to eq true
    end
end