class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, :date_of_birth, presence: true
  validates :password, length: { minimum: 6 }, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i }
  with_options presence: true do
    validates :last_name, :first_name, format: { with: /\A[ぁ-ん一-龥]+\z/ }
    validates :last_name_kana, :first_name_kana, format: { with: /\A[ァ-ン]+\z/ }
  end
end
