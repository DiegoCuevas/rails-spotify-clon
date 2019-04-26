class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :providers

  devise :omniauthable, omniauth_providers: %i[facebook github]

  after_create :send_welcome_mail

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
    Provider.find_or_create_by(name: auth.provider, uid: auth.uid, user_id: user.id)
    user
  end
  def send_welcome_mail
    UserMailer.welcome_user(self).deliver_later
  end

  def admin?
    self.role == "admin"
  end

  def regular?
    self.role == "regular"
  end

end
