class Category < ApplicationRecord
  belongs_to :user
  has_many :operations

  validates :name, presence:true
  validates :description, presence:true
end
