class Song < ApplicationRecord
  has_and_belongs_to_many :artists, join_table: 'associations', dependent: :destroy
  has_and_belongs_to_many :albums, join_table: 'associations', dependent: :destroy
  validates :title, presence: true, length: { maximum: 100 }
  validates :duration, presence: true, numericality: { only_integer: true }
  validates :rating, presence: true, numericality: { only_integer: true }
  validates :progress, presence: true, numericality: { only_integer: true }
end
