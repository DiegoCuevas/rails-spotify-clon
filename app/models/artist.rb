class Artist < ApplicationRecord
  has_one_attached :cover
  has_and_belongs_to_many :songs, join_table: 'associations', dependent: :destroy
  has_and_belongs_to_many :albums, join_table: 'associations', dependent: :destroy
  validates :name, presence: true
  validates :age, presence: true, numericality: { only_integer: true }
end
