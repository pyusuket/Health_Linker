class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image
  
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.last_name = "guest"
      user.first_name = "user"
      user.last_name_kana = "ゲスト"
      user.first_name_kana = "ユーザー"
      user.birthday = "2024/1/1"
      user.sex = "男性"
      user.user_status = "true"
  end
  end
end