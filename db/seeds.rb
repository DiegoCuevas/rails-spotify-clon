# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

songs_array = []
albums_array = []
artits_array = []

# seed movies
10.times do
  songs_array << Song.create(
    title: Faker::Movie.quote,
    duration: rand(7200) + 1,
    rating: rand(5) + 1,   
    progress: 0
  )  
end

10.times do
  albums_array << Album.create(
    title: Faker::Movie.quote,
    rating: rand(5) + 1,
  )  
end

10.times do
  artits_array << Artist.create(
    name: Faker::Movie.quote,
    age: rand(40) + 10
  )  
end

# songs_array.each do |s|
#   s.update(
#     albums: albums_array[(1..3)],
#     artists: artists_array[(1..3)],
#   )

# end

# albums_array.each do |s|
#   s.update(
#     songs: songs_array[(1..3)],
#     artists: artists_array[(1..3)],
#   )

# end
