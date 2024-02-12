class Post < ApplicationRecord
  has_one_attached :image
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :post
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :nices, dependent: :destroy
  
  def niced_by?(user)
    nices.exists?(user_id: user.id)
  end
end
