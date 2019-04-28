class UserMailer < ApplicationMailer
  default from: 'no-reply@able.com',
  return_path: 'mayra@able.com'

  def self.info_most_popular_songs
    Song.joins(:ratings).where("ratings.value = 1").group("id").order("COUNT(ratings.ratingable_id) DESC").limit(3)
  end

  def welcome_user(user)
    @user = user
    @songs = Song.joins(:ratings).where("ratings.value = 1").group("id").order("COUNT(ratings.ratingable_id) DESC").limit(3)
    email_with_name = %("#{@user.username}" <#{@user.email}>)

    mail(to: email_with_name, subject: 'Welcome to Spotify')
  end

  def self.report_most_popular_songs(users)
    most_popular_songs = info_most_popular_songs
    new_data = most_popular_songs.reduce(""){ | cad, song | "#{cad},#{song.id}"}
    unless $most_popular_songs && $most_popular_songs == new_data
      $most_popular_songs = new_data
      users.each do |user|
        send_updated_info(user, most_popular_songs, 'Most popular songs').deliver_now
      end
    end
  end

  def self.report_most_popular_albums(users)
    most_popular_album = Album.joins(:ratings).where("ratings.value = 1").group("id").order("COUNT(ratings.ratingable_id) DESC").limit(3)
    new_data = most_popular_album.reduce(""){ | cad, album | "#{cad},#{album.id}"}
    unless $most_popular_album && $most_popular_album == new_data
      $most_popular_album = new_data
      users.each do |user|
        send_updated_info(user, most_popular_album, 'Most popular albums').deliver_now
      end
    end
  end

  def self.report_most_popular_artists(users)
    most_popular_artist = Artist.joins(songs: :ratings).where("ratings.value = 1").group("id").order("COUNT(ratings.ratingable_id) DESC").limit(3)
    new_data = most_popular_artist.reduce(""){ | cad, artist | "#{cad},#{artist.id}"}
    unless $most_popular_artist && $most_popular_artist == new_data
      $most_popular_artist = new_data
      users.each do |user|
        send_updated_info(user, most_popular_artist, 'Most popular artists').deliver_now
      end
    end
  end

  def send_updated_info(user, data, mail_subject)
    @user = user
    @data = data
    @msg = mail_subject
    email_with_name = %("#{user.username}" <#{user.email}>)
    mail(to: email_with_name, subject: mail_subject)
  end

  def send_new_album
    @album = params[:album]
    mail(to: User.all.pluck(:email), subject: 'New album has been published')
  end

  def self.send_request(artist)
    emails = User.all.map {|user| %("#{user.username}" <#{user.email}>) }
    username = User.all.pluck(:username)
    emails.each.with_index { |email,index|
      new_artist_email_all_users(email,artist,username[index]).deliver_later
      }
  end

  def new_artist_email_all_users(email, artist, username)
    @item = artist
    @username = username
    @albums = artist.albums
    @artist = artist
    attachments.inline[artist.id.to_s + ".png"] = File.read(ActiveStorage::Blob.service.send(:path_for, artist.cover.key)) if artist.cover.attached?
    mail(to: email, subject: 'New Artist in Spotify!')
  end

end
