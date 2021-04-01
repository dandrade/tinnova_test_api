class Beer < ApplicationRecord

  validates :name, :abv, presence: true
  validates :name, uniqueness: true
end
