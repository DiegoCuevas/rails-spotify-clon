class AdminMailer < ApplicationMailer
  default to: -> { User.where(role: 'admin').pluck(:email) },
          from: 'hola@spotifyclon.com'

  def new_user_created
    @user = params[:user]
    mail(subject: 'New user register')
  end
end
