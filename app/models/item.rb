class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :orders_details, dependent: :destroy
  attachment :image

  validates :genre_id, presence: true
  validates :name ,presence: true
  validates :introduction, presence: true
  validates :price, presence: true, format: { with: /\A[0-9]+\z/i, }
end
