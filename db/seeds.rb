# My awesome seed
require "faker"

def get_image(file_name)
  { io: File.open(File.join(Rails.root, "/app/assets/images/seed/#{file_name}")), filename: file_name }
end

artist = [
  { name: 'Hyde', image: 'artists/hyde.jpg' },
  { name: 'Nujabes', image: 'artists/nujabes.jpeg' },
  { name: 'Frank sinatra', image: 'artists/frank-sinatra.jpeg' },
  { name: 'Taylor Swift', image: 'artists/taylor-swift.png' },
  { name: 'The pillows', image: 'artists/the-pillows.jpg' }
]

songs = [
  { title: 'Seasons', image: 'songs/seasons-call-me.jpg' },
  { title: 'Folklore', image: 'songs/folklore.jpg' },
  { title: 'My way', image: 'songs/last-dinosaur.jpg' },
  { title: 'Love Story', image: 'songs/love-story.jpeg' },
  { title: 'Nujabes', image: 'songs/folklore.jpg' }
]

albums = [
  { title: 'Album Hyde', image: 'albums/hyde-album.jpg' },
  { title: 'Album Nujabes ', image: 'albums/nujabes-album.jpg' },
  { title: 'Album Sinatra', image: 'albums/sinatra-album.jpeg' },
  { title: 'Album Taylor', image: 'albums/taylor-album.jpeg' },
  { title: 'Album The Pillows', image: 'albums/the-pillows-album.jpg' }
]

# create main users
User.create(email: "davis.con.fab@gmail.com", username:'condef5',password:'conde123', role:'regular')
User.create(email: "yummta+uno@gmail.com", username:'yummta',password:'aaaaaa', role:'admin')
User.create(email: "yummta+dos@gmail.com",username:'mayra', password: 'aaaaaa', role:'admin')

# create others users
30.times do
  User.create(
    email: Faker::Internet.email,
    username: Faker::Internet.user_name,
    password:'aaaaaa'
  )
end

# create artists
artist.each do |artist|
  Artist.create(
    name: artist[:name],
    age: rand(40) + 10,
    cover: get_image(artist[:image])
  )
end

# create albums
Artist.all.each_with_index do |artist, index|
  artist.albums << Album.create(
    title: albums[index][:title],
    cover: get_image(albums[index][:image])
  )
  User.all.each { |user| Album.last.ratings.create(value: [1, -1].sample, user_id: user.id)}
end

# create songs
Album.all.each_with_index do |album, index|
    album.songs << Song.create(
      title: songs[index][:title],
      duration: rand(7200) + 1,
      progress: 0,
      cover: get_image(songs[index][:image])
    )
    User.all.each { |user| Song.last.ratings.create(value: [1, -1].sample, user_id: user.id)}
end

# add relations
Artist.all.each do |artist|
  artist.albums.each do |album|
    album.songs.each do |song|
      artist.songs << song
    end
  end
end

p 'Seed added correctly'
