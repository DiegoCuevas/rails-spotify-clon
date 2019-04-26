class UserMailer < ApplicationMailer
  default from: 'no-reply@able.com',
  return_path: 'mayra@able.com'

  def welcome_user(user)
    @user = user
    email_with_name = %("#{@user.username}" <#{@user.email}>)
    mail(to: email_with_name, subject: 'Welcome to Spotify')
  end
end
