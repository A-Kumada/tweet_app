# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Example User",
             email: ENV['SANMPLEUSER_MAIL'],
             profile: "サンプル",
             birthday: "19900202",
             password: ENV['SAMPLEUSER_PASS'],
             password_confirmation: ENV['SAMPLEUSER_PASSCONF'],
             is_active: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  profile = "サンプル#{n+1}"
  birthday = "19900301"
  password = "password"
  User.create!(name:  name,
               email: email,
               profile: profile,
               birthday: birthday,
               password:              password,
               password_confirmation: password,
               is_active: true)
end

# マイクロポスト
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.tweets.create!(content: content) }
end

# ユーザーフォローのリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }