# frozen_string_literal: true

class OfficeRepresentative < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable, :rememberable, :validatable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable, :recoverable

  include DeviseTokenAuth::Concerns::User

  before_save { email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :tel, presence: true
  validates :postal, presence: true, length: { is: 7 }
  validates :address, presence: true, length: { maximum: 255 }
end
