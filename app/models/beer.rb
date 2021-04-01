class Beer < ApplicationRecord

  validates :name, :abv, presence: true
  validates :name, uniqueness: true

  has_many :user_beers
  has_many :users, through: :user_beers
end
