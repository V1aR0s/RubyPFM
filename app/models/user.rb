class User < ApplicationRecord
  has_secure_password
  has_many :categories
  has_many :operations

  before_save :capitalize_name_and_suranme


  validates :name, presence: true, on: :create

  validates :surname, presence: true, on: :create

  validates :email, presence: true, uniqueness: true, confirmation: true, format: { with: /\A([^\}\{\]\[@\s\,]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: " is invalid" }, on: :create

  validates :password, presence: true, length: { minimum: 4 }, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "must contain at least one lowercase letter, one uppercase letter, and one digit" }, on: :create

  def capitalize_name_and_suranme
    name.capitalize!
    surname.capitalize!
  end
end
