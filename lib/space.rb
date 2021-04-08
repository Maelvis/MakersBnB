require 'pg'
require_relative 'database_connection'

class Space
  attr_reader :name, :description, :price

  def initialize(id:, name:, description:, price:, host_id:)
    @id = id
    @name = name
    @description = description
    @price = price
    @host_id = host_id
  end

  def self.create_space(name:, description:, price:)
    result = DatabaseConnection.query("INSERT INTO spaces (name, description, price, host_id) VALUES('#{name}', '#{description}', '#{price}', '#{host_id}') RETURNING id, name, description, price ")
    Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], host: result[0]['host_id'])
  end

  def self.view_my_spaces(host_id:)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE HOST = '#{host_id}';")
    result.map do |space| space
      Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], host_id: result[0]['host_id'])
    end
  end

  def self.view_all_spaces()
    result = DatabaseConnection.query("SELECT * FROM spaces;")
    result.map do |space| space
      Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], host_id: result[0]['host_id'])
    end
  end

end