class User < ApplicationRecord

  has_one :profile, dependent: :destroy
  has_many :pieces

  accepts_nested_attributes_for :profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :create_profile

  def create_profile
    profile = Profile.create
    self.default_card = profile.id
  end

end
