class Payment < ActiveRecord::Base
  validates :settlement_date, presence: true
  validates :balance, presence: true
  validates :description, presence: true, length: { maximum: 30 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100000000 }
  belongs_to :user
end
