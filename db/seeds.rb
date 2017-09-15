# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


20.times do |n|
  email = Faker::Internet.email
  password = "password"
  name = Faker::Name.name
  image_url = Faker::Avatar.image
  User.create!(
               email: email,
               password: password,
               password_confirmation: password,
               name: name,
               uid: User.create_unique_string,
               provider: n,
               image_url: image_url,
               )

  content = Faker::Coffee.blend_name
  Topic.create!(
               content: content,
               user_id: User.ids.sample
              )

  content = Faker::Cat.name
  Comment.create!(
                content: content,
                user_id: User.ids.sample
                )
end
