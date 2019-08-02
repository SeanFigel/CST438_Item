class Item < ActiveRecord::Base
    validates :description, presence: true
    validates :price, presence: true
    validates :stock, presence: true
    validates :price, numericality: { greater_than: 0 }
    validates :stock, numericality: { only_integer: true }
    validates :stock, numericality: { greater_than_or_equal_to: 0 }
end