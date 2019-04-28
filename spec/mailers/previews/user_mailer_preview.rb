# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def new_artist_email_all_users
    UserMailer.new_artist_email_all_users('luciagirasoles@gmail.com', Artist.last, 'luciagirasoles')
  end

end
