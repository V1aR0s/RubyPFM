require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "check the create of normal user" do
    user = User.new(name: "Name", surname: "Surname", email: "email@gmail.com", password: "Password123", password_confirmation: "Password123")
    
    assert(user.valid?)
  end

  test "check the create of user wirhout password" do
    user = User.new(name: "Name_Witout_Password", surname: "Surname_Witout_Password", email: "email.without.password@gmail.com")
    assert_not(user.valid?)
  end


  test "check the create of user without confirm password" do
    user = User.new(name: "Name_Witout_confirm_Password", surname: "Surname_Witout_confirm_Password", email: "email.without.confirm.password@gmail.com",  password: "password123")
    assert_not(user.valid?)
  end


  test "check the create of user without name" do
    user = User.new(surname: "Surname_Witout", email: "email.without@gmail.com",  password: "password123", password_confirmation: "password123")
    assert_not(user.valid?)
  end

  test "check the create of user with other confirm name" do
    user = User.new(name: "PasswordOther", surname: "Surname_Witout_confirm_Password", email: "emaild@gmail.com",  password: "password123", password_confirmation: "drowssap")
    assert_not(user.valid?)
  end
end
