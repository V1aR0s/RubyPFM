class Operation < ApplicationRecord
  belongs_to :category
  belongs_to :user
  validates :description, presence:true
  validates :odate, presence:true, inclusion: { in: ->(date) { DateTime.new..DateTime.now } }
  validates :amount, presence:true, numericality: {greater_than: 0}



end
