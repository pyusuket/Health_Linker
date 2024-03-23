# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Faker::Config.locale = :ja

# 管理者用(email/password)
Admin.create!(
  email: 'admin@test.com',
  password: 'test12'
)

# Tagテーブルの内容
tags = ["旅行", "散歩・ジョギング", "登山", "家族", "娯楽", "終活", "日課", "その他"]

tags.each do |tag_name|
  Tag.create(name: tag_name)
end

# 日本人の名前リストを定義する
JAPANESE_NAMES = [
  "佐藤 太郎",
  "鈴木 次郎",
  "田中 花子",
]

# Userテーブル
110.times do |n|
  user = User.create!(
    user_name: JAPANESE_NAMES.sample,
    email: Faker::Internet.unique.email,
    password: "test12",
    password_confirmation: "test12",
    sex: Faker::Gender.binary_type,
    introduction: Faker::Lorem.sentence(word_count: 10),
    birthday: Faker::Date.birthday(min_age: 18, max_age: 100),
    postal_code: Faker::Address.postcode,
    prefecture: Faker::Address.state,
    city: Faker::Address.city,
    apartment: Faker::Address.secondary_address
  )
  profile_image_paths = Dir.glob(Rails.root.join('app', 'assets', 'images', 'profile_image', '*'))
  random_profile_image_path = profile_image_paths.sample
  profile_image_file = File.open(random_profile_image_path)
  user.profile_image.attach(io: profile_image_file, filename: File.basename(random_profile_image_path))
end

# Postテーブル
user_ids = User.pluck(:id)
image_paths = Dir.glob(Rails.root.join('app/assets/images/post', '*'))

# 既存のタグを取得
tags = Tag.all

50.times do
  post = Post.new(
    user_id: user_ids.sample, 
    body: Faker::Lorem.sentence,
    views_count: Faker::Number.between(from: 0, to: 100)
  )

  # imagesの数を1～6枚のランダムな数で決定
  num_images = rand(1..6)
  # imagesの配列を初期化
  images = []

  # 画像をランダムに選択してimagesに追加
  num_images.times do
    random_image = image_paths.sample
    images << random_image
  end

  # imagesカラムにランダムに選択した画像を添付
  images.each do |image|
    post.images.attach(io: File.open(image), filename: File.basename(image), content_type: 'image/jpeg')
  end

  # タグの数を0～9のランダムな数で決定
  num_tags = rand(0..9)
  # 既存のタグからランダムに選択してpostに関連付ける
  post.tags = tags.sample(num_tags)

  # 一時的にバリデーションを無効にして保存を試みる
  post.save(validate: false)

  # バリデーションを手動で実行
  unless post.valid?
    puts "Validation failed for post: #{post.errors.full_messages.join(', ')}"
  end
end


