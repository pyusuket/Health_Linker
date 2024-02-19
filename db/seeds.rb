# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 管理者用(email/password)
Admin.create!(
  email: 'admin@test.com',
  password: 'test12'
)

# Tagテーブルの内容
tags = ["旅行", "散歩・ジョギング", "登山", "家族", "娯楽", "終活", "日課"]

tags.each do |tag_name|
  Tag.create(name: tag_name)
end