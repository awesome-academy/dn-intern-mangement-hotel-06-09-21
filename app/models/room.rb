class Room < ApplicationRecord
  has_many :furnitures, dependent: :destroy
  has_many :receipts, dependent: :destroy
  has_many_attached :images

  scope :latest, ->{order name: :desc}
  scope :search_name_furnitures, (lambda do |key|
    joins(:furnitures)
      .where("furnitures.name LIKE ?", "%#{key}%")
  end)
  scope :search_rooms, ->(key){where "rooms.name LIKE ?", "%#{key}%"}
end
