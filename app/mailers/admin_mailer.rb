class AdminMailer < ApplicationMailer
  default to: -> { User.where(role: 'admin').pluck(:email) },
          from: 'hola@spotifyclon.com'

  def new_user_created
    @user = params[:user]
    mail(subject: 'New user register')
  end

  def self.report_less_popular_songs(users)
    less_popular_songs = Song.joins(:ratings).where("ratings.value = -1").group("id").order("COUNT(ratings.ratingable_id) DESC").limit(3)
    new_data = less_popular_songs.reduce(""){ | cad, song | "#{cad},#{song.id}"}
    unless $less_popular_songs && $less_popular_songs == new_data
      $less_popular_songs = new_data
      users.each do |user|
        send_updated_info(user, less_popular_songs, 'Less popular songs').deliver_now
      end
    end
  end

  def self.report_most_rated_songs(users)
    most_rated_songs = Song.joins(:ratings).group("id").order("SUM(ratings.value) DESC").limit(3)
    new_data = most_rated_songs.reduce(""){ | cad, song | "#{cad},#{song.id}"}
    unless $most_rated_songs && $most_rated_songs == new_data
      $most_rated_songs = new_data
      users.each do |user|
        send_updated_info(user, most_rated_songs, 'Most rated songs').deliver_now
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
end
