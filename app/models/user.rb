class User < ApplicationRecord

  has_one :profile
  has_many :pieces
  has_many :deals

  accepts_nested_attributes_for :profile, :allow_destroy => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  before_create :set_default_role

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  private
    def set_default_role
    self.role_id ||= Role.find_by_name('Member')
  end

end
