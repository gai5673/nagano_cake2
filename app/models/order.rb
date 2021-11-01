class Order < ApplicationRecord
  belongs_to :customer
  has_many :orders_details, dependent: :destroy

  enum payment: {
    "クレジットカード" => 0,
    "銀行振込" => 1,
  }

end
