class Heart < ApplicationRecord
  belongs_to :piece
  has_and_belongs_to_many :users
end
