class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  VALID_NAME_PRONOUNCE_REGEX = /\A[\p{katakana}]+\z/
  validates :nickname, presence: true
  validates :password, presence:true, format: {with: VALID_PASSWORD_REGEX}
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_pronounce, presence: true, format: { with: VALID_NAME_PRONOUNCE_REGEX}
  validates :first_name_pronounce, presence: true, format: { with: VALID_NAME_PRONOUNCE_REGEX}
  validates :birthday, presence: true
end
