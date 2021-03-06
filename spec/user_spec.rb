require 'database_connection'
require 'user'
require 'database_helper'

describe '.create' do
  it 'creates a new user' do
    user = User.create(email: 'test@example.com', password: 'password123')

    persisted_data = persisted_data(table: :users, id: user.id)

    expect(user).to be_a User
    expect(user.id).to eq persisted_data.first['id']
    expect(user.email).to eq 'test@example.com'
  end
end

describe '.create' do
    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password123')
  
      User.create(email: 'test@example.com', password: 'password123')
    end
end

describe '.authenticate' do
    it 'returns a user given a correct username and password, if one exists' do
      user = User.create(email: 'test@example.com', password: 'password123')
      authenticated_user = User.authenticate(email: 'test@example.com', password: 'password123')

      expect(authenticated_user.id).to eq user.id
    end
end