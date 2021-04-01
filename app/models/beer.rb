class Beer < ApplicationRecord

  validates :name, :abv, presence: true
  validates :name, uniqueness: true

  has_many :user_beers
  has_many :users, through: :user_beers

  def self.get_beer(beer_id, user)
    response = Beers::PunkService.new.retrieve_beer(beer_id)
    response = response.first
    unless response.empty?
      beer = find_or_create_by(response)
      user_beer = user.user_beers.find_or_create_by(beer: beer).update!(seen_at: Time.current.strftime('%Y-%m-%d %H:%M:%S'))
    end
    response
  end

end
