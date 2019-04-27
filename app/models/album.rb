class Album < ApplicationRecord
  has_one_attached :cover

  has_and_belongs_to_many :artists, join_table: 'associations', dependent: :destroy
  has_and_belongs_to_many :songs, join_table: 'associations', dependent: :destroy
  has_many :ratings, as: :ratingable  

  validates :title, presence: true, length: { maximum: 100 }

  def like?(user)
    ratings.where(user_id: user.id, value: 1).any?
  end
 
  def unlike?(user)
    ratings.where(user_id: user.id, value: -1).any?
  end
end
