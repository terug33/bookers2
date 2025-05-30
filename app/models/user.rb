class User < ApplicationRecord
  validates :name, presence: true, length: {minimum: 2, maximum:20}, uniqueness: true 
  validates :introduction, length: {maximum: 50}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_one_attached :profile_image
end
