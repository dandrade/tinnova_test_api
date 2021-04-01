class Beer < ApplicationRecord

  validates :name, :abv, presence: true
  validates :name, uniqueness: true

  has_many :user_beers
  has_many :users, through: :user_beers

  def self.get_beers(beer_name: nil, abv: nil, page_number: 1)
    Beers::PunkService.new.retrieve_beers(beer_name: beer_name, abv: abv, page_number: page_number)
  end

  def self.get_beer(beer_id, user)
    response = Beers::PunkService.new.retrieve_beer(beer_id)
    response = response.first
    unless response.empty?
      beer = find_or_create_by(response)
      user_beer = user.user_beers.find_or_create_by(beer: beer)
    end
    response
  end

end
