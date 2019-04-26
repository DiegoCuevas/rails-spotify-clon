class Album < ApplicationRecord
  has_one_attached :cover
  has_and_belongs_to_many :artists, join_table: 'associations', dependent: :destroy
  has_and_belongs_to_many :songs, join_table: 'associations', dependent: :destroy
  validates :title, presence: true, length: { maximum: 100 }
  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: { in: [-1, 1] }
end
