class User < ApplicationRecord
  has_secure_password

  has_many :user_beers
  has_many :beers, through: :user_beers

  def to_token
    {
        id: self.id,
        name: self.name,
        username: self.username,
    }
  end

  def all_beers(favorite: nil)
    result = []
    favs = user_beers.includes(:beer)
    favs = favs.where(favorite: true) if favorite.present?
    favs.each do |fav|
      result << fav.beer.attributes.merge!(
        favorite: fav.favorite
      )
    end

    result
  end
end
