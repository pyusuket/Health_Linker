class Post < ApplicationRecord
  has_many_attached :images
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings 
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :nices, dependent: :destroy
  
  accepts_nested_attributes_for :taggings
  
  def niced_by?(user)
    nices.exists?(user_id: user.id)
  end
  
  def save_workout_tags(tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.workout_tags.pluck(:name) unless self.workout_tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.workout_tags.delete WorkoutTag.find_by(name:old_name)
    end

    # 新しいタグを保存
    new_tags.each do |new_name|
      workout_tag = WorkoutTag.find_or_create_by(name:new_name)
      self.workout_tags << workout_tag
    end
  end
  
end
