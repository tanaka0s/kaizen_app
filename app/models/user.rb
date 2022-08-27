class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :proposals
  has_many :executions
  has_many :comments

  validates :name, presence: true
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'is invalid.Include both letters and numbers'

  def self.guest
    find_or_create_by!(email: 'guest@test.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = '山田太郎'
    end
  end
end
