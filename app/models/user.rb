class User < ApplicationRecord
  validates_presence_of :name, :email
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :password

  has_secure_password

  has_many :user_parties
  has_many :viewing_parties, through: :user_parties

  def hosted_parties
    viewing_parties.where('user_parties.host = true')
  end

  def guest_parties
    viewing_parties.where('user_parties.host = false')
  end
end