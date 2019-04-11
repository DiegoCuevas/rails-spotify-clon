# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'


4.times do
  Artist.create(
    name: Faker::Music::RockBand.name,
    age: rand(40) + 10
  )  
end

Artist.all.each do |artist|
  4.times do
    artist.albums << Album.create(
      title: Faker::Music.album,
      rating: rand(5) + 1,
    ) 
  end
end

Album.all.each do |album|
  10.times do
    album.songs << Song.create(
      title: Faker::Music::UmphreysMcgee.song,
      duration: rand(7200) + 1,
      rating: rand(5) + 1,   
      progress: 0
    )  
  end
end
