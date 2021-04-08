class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validetes :last_name, presence: true
  validetes :first_name, presence: true
  validetes :last_name_pronounce, presence: true
  validetes :first_name_pronounce, presence: true
  validetes :birthday, presence: true
end
