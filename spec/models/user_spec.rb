require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'save successfully given a user with all 4 categories' do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'johndoe@email.com', password: 'password', password_confirmation: 'password')

      expect(@user).to be_valid
    end
    

    it 'should have an error if the password is not set' do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'johndoe@email.com', password: nil, password_confirmation: nil)
      @user.save

      expect(@user.errors.full_messages).to include("Password can't be blank")
    end


    it 'should have an error if password and password_confirmation do not match' do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'johndoe@email.com',  password: 'password', password_confirmation: 'pass')
      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end


    it 'should have an error if email already exists' do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'johndoe@email.com',  password: 'password', password_confirmation: 'password')
      @user.save
      @user2 = User.new(first_name: 'Jon', last_name: 'Doe', email: 'johndoe@email.com', password: 'password', password_confirmation: 'password')
      @user2.save

      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end


    it 'should have an error if email already exists and is not case sensitive' do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@email.com',  password: 'password', password_confirmation: 'password')
      @user.save
      @user2 = User.new(first_name: 'Jon', last_name: 'Doe', email: 'TEST@email.com', password: 'password', password_confirmation: 'password')
      @user2.save

      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end


    it 'should have an error if the last name is not set' do
      @user = User.new(first_name: 'John', last_name: nil, email: 'johndoe@email.com', password: 'password', password_confirmation: 'password')
      @user.save

      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end


    it 'should have an error if the email is not set' do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: nil, password: 'password', password_confirmation: 'password')
      @user.save

      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should have an error if the password is too short' do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: nil, password: 'pass', password_confirmation: 'pass')
      @user.save

      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should login if user has valid credentials' do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'johndoe@email.com', password: 'password', password_confirmation: 'password')
      @user.save

      @logged_in_user = User.authenticate_with_credentials('johndoe@email.com', 'password')
      expect(@logged_in_user).to be_a User
    end


    it 'should not login if password is not valid' do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'johndoe@email.com', password: 'password', password_confirmation: 'password')
      @user.save
      
      @logged_in_user = User.authenticate_with_credentials('johndoe@email.com', 'passw')
      expect(@logged_in_user).to be_nil
    end


    it 'should not login if email is not valid' do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'johndoe@email.com', password: 'password', password_confirmation: 'password')
      @user.save
      
      @logged_in_user = User.authenticate_with_credentials('joe@email.com', 'password')
      expect(@logged_in_user).to be_nil
    end


    it 'should login if email has trailing spaces before or after' do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'johndoe@email.com', password: 'password', password_confirmation: 'password')
      @user.save
      
      @logged_in_user = User.authenticate_with_credentials(' johndoe@email.com ', 'password')
      expect(@logged_in_user).to be_a User
    end


    it 'should login if email is not case sensitive' do
      @user = User.new(first_name: 'John', last_name: 'Doe', email: 'johndoe@email.com', password: 'password', password_confirmation: 'password')
      @user.save
      
      @logged_in_user = User.authenticate_with_credentials(' JOHNDOE@email.com ', 'password')
      expect(@logged_in_user).to be_a User
    end
  end
end
