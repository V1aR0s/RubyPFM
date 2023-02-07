class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true

  validates :surname, presence: true

  validates :email, presence: true, uniqueness: true, confirmation: true

end
