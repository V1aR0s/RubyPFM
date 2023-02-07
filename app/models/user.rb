class User < ApplicationRecord
  has_secure_password
  has_many :category

  before_save :capitalize_name_and_suranme


  validates :name, presence: true

  validates :surname, presence: true

  validates :email, presence: true, uniqueness: true, confirmation: true, format: { with: /\A([^\}\{\]\[@\s\,]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: " is invalid" }



  def capitalize_name_and_suranme
    name.capitalize!
    surname.capitalize!
  end
end
