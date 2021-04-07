require 'pg'
require_relative 'database_connection'

class Space
  attr_reader :name, :description, :price

  def initialize(id:, name:, description:, price:, host:)
    @id = id
    @name = name
    @description = description
    @price = price
    @host = host #User.id
  end

  def self.create_space(name:, description:, price:, host:)
    result = DatabaseConnection.query("INSERT INTO #{DatabaseConnection.dbname} (name, description, price, host) VALUES('#{name}', '#{description}', '#{price}') RETURNING id, name, description, price ")
    Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], host: result[0]['host'])
  end

  def self.view_my_spaces(host:)
    result = DatabaseConnection.query("SELECT * FROM #{DatabaseConnection.dbname} WHERE HOST = '#{host}';")
    result.map do |space| space
      Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], host: result[0]['host'])
    end
  end

  def self.view_all_spaces()
    result = DatabaseConnection.query("SELECT * FROM #{DatabaseConnection.dbname};")
    result.map do |space| space
      Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], host: result[0]['host'])
    end
  end

end