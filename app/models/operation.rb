class Operation < ApplicationRecord
  belongs_to :category
  validates :odate, presence:true
  validates :amount, presence:true, numericality: { greater_than: 0}
end
