class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook github]

  has_many :providers
  has_many :ratings

  after_create :send_notification_new_users_to_admins
  after_create :send_welcome_mail

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
    Provider.find_or_create_by(name: auth.provider, uid: auth.uid, user_id: user.id)
    user
  end

  def admin?
    self.role == "admin"
  end

  def regular?
    self.role == "regular"
  end

  private
  def send_welcome_mail
    UserMailer.welcome_user(self).deliver_later
  end

  def send_notification_new_users_to_admins
    AdminMailer.with(user: self).new_user_created.deliver_later
  end

end
