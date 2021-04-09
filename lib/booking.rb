require 'pg'
require_relative 'database_connection'

class Booking
    attr_reader :space_id, :guest_id, :host_id, :start_date, :leave_date, :id, :confirmed
    def initialize(id:, space_id:, guest_id:, host_id:, start_date:, leave_date:)
        @id = id
        @space_id = space_id
        @guest_id = guest_id
        @host_id = host_id
        @start_date = start_date
        @leave_date = leave_date
    end


    def self.create(space_id:, guest_id:, host_id:, start_date:, leave_date:)
        result = DatabaseConnection.query("INSERT INTO bookings (space_id, guest_id, host_id, start_date, leave_date) VALUES('#{space_id}', '#{guest_id}', '#{host_id}', '#{start_date}', '#{leave_date}') RETURNING id, space_id, guest_id, host_id, start_date, leave_date;")
        Booking.new(id: result[0]['id'], space_id: result[0]['space_id'], guest_id: result[0]['guest_id'], host_id: result[0]['host_id'], start_date: result[0]['start_date'],leave_date: result[0]['leave_date'])
    end

    def self.confirm(booking_id:)
        result = DatabaseConnection.query("UPDATE bookings SET confirmed = true WHERE id = #{booking_id};")
        return true
    end
end