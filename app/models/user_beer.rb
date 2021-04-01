class UserBeer < ApplicationRecord
  belongs_to :user
  belongs_to :beer

  after_validation :set_seen_at, on: [:create, :update]

  def self.favorite_beer(beer_id, user)
    Beer.get_beer(beer_id, user)
    user_beer = find_by(beer_id: beer_id, user_id: user.id)

    return nil unless user_beer.present?

    user_beer.favorite = !user_beer.favorite
    user_beer.save

    user_beer.beer.attributes.merge!(
      favorite: user_beer.favorite
    )
  end

  private
  def set_seen_at
    self.seen_at = Time.current.strftime('%Y-%m-%d %H:%M:%S')
  end

end
