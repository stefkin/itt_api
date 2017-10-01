# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ips = (1..50).map { Faker::Internet.ip_v4_address }
logins = (1..100).map  { Faker::Internet.user_name }

200_000.times do |i|
  Post::Create.new.call(
    title: Faker::Lorem.sentence(1),
    content: Faker::Lorem.sentence(10),
    login: logins.sample,
    author_ip: ips.sample
  )
  puts i
end
