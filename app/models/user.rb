class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  ADMIN_LIST=["edo.gi00@hotmail.it","giuggioloni.1881780@studenti.uniroma1.it"]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
        :omniauthable, omniauth_providers: [:google_oauth2]
  enum role: [:player,:creator,:admin]
  after_initialize :set_default_role
  def set_default_role
    puts "NEW record added"
    if ADMIN_LIST.include? self.email
      self.role ||=:admin
    else
      self.role||=:player
    end
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider,uid: auth.uid).first_or_create do |user|
      user.email=auth.info.email
      user.password=Devise.friendly_token[0,20]
      user.full_name=auth.info.name
      user.avatar_url=auth.info.image
    end
  end
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.google_data"] && session["devise.google_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
end
