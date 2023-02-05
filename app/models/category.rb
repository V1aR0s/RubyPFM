class Category < ApplicationRecord
  has_many :operations
  validates :name, uniqueness:true, presence:true
  validates :description, presence:true
end
