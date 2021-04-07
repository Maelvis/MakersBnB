require 'pg'

class Space
  attr_reader :name, :description, :price

  def initialize(id:, name:, description:, price:, host:)
    @id = id
    @name = name
    @description = description
    @price = price
    @host = #User.id
  end

  def self.create_space(name:, description:, price:, host:)
    #if ENV['ENVIRONMENT'] == 'test'
      #connection = PG.connect(dbname: '#')
    #else
      #connection = PG.connect(dbname: '#')
    #end
    result = connection.exec("INSERT INTO # (name, description, price, host) VALUES('#{name}', '#{description}', '#{price}') RETURNING id, name, description, price ")
    Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], host: result[0]['host'])
  end

  def self.view_my_spaces(host:)
    #if ENV['ENVIRONMENT'] == 'test'
      #connection = PG.connect(dbname: '#')
    #else
      #connection = PG.connect(dbname: '#')
    #end
    result = connection.exec("SELECT * FROM # WHERE HOST = '#{host}';")
    result.map do |space| space
      Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], host: result[0]['host'])
    end

  def self.view_all_spaces()
    #if ENV['ENVIRONMENT'] == 'test'
      #connection = PG.connect(dbname: '#')
    #else
      #connection = PG.connect(dbname: '#')
    #end
    result = connection.exec("SELECT * FROM #;")
    result.map do |space| space
      Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], host: result[0]['host'])
    end
  end

end