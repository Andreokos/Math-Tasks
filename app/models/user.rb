class User < ApplicationRecord
  has_many :tasks
  has_many :comments
  has_many :likes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github, :google_oauth2]

  validates :name, presence: true, uniqueness: false

  def self.from_omniauth(access_token)
    user = User.where(email: access_token.info.email).first

    unless user
      user = User.create(email: access_token.info.email,
                         name: access_token.info.name,
           password: Devise.friendly_token[0,20]
        )
    end
    user.name = access_token.info.name
    user.image = access_token.info.image
    user.save
    user
  end
end
