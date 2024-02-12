class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :posts
end
