# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :rememberable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  # jsonレスポンスに:typeを追加する
  def as_json(options={})
    super(options.merge({:methods => :type}))
  end
end
