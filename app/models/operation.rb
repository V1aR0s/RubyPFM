class Operation < ApplicationRecord

  belongs_to :category
  belongs_to :user
  validates :odate, presence:true
  validates :amount, presence:true, numericality: { greater_than: 0}


  
end
