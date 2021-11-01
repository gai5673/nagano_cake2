class Addresse < ApplicationRecord
  belongs_to :customer
  validates :last_name,  presence: true
  validates :first_name, presence: true
  validates :postal_code,  presence: true, format: {with: /\A\d{7}\z/}
  validates :address, presence: true
end
