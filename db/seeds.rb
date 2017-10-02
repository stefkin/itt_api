# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ips = (1..50).map { Faker::Internet.ip_v4_address }
logins = (1..100).map  { Faker::Internet.user_name }

ip_login_pairs = ips.concat(ips).zip(logins)

200_000.times do |i|
  ip, login = ip_login_pairs.sample

  Post::Create.new.call(
    title: Faker::Lorem.sentence(1),
    content: Faker::Lorem.sentence(10),
    login: login,
    author_ip: ip
  )

  puts i
end
