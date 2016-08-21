class User < ApplicationRecord

  has_one :profile
  has_many :pieces

  accepts_nested_attributes_for :profile, :allow_destroy => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
