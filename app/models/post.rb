class Post < ApplicationRecord
  has_many_attached :images
  has_many          :taggings, dependent: :destroy
  has_many          :tags    , through:   :taggings 
  has_many          :comments, dependent: :destroy
  has_many          :nices   , dependent: :destroy
  belongs_to        :user
  
  accepts_nested_attributes_for :taggings
  
  # バリデーション
  validate  :validate_images_presence
  validates :body            , presence: true
  validates :taggings        , presence: true
  
  def niced_by?(user)
    nices.exists?(user_id: user.id)
  end
  
  # タグの処理
  def save_workout_tags(tags)
    current_tags = self.workout_tags.pluck(:name) unless self.workout_tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags
    old_tags.each do |old_name|
      self.workout_tags.delete WorkoutTag.find_by(name:old_name)
    end

    new_tags.each do |new_name|
      workout_tag = WorkoutTag.find_or_create_by(name:new_name)
      self.workout_tags << workout_tag
    end
  end
  
  private

  def validate_images_presence
    if images.attached? && images.size > 6
      errors.add(:images, "は最大で6枚までです。")
    elsif images.blank?
      errors.add(:images, "を選択してください。")
    end
  end
  
end
