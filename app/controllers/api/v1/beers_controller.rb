class Api::V1::BeersController < ApplicationController
  before_action :authenticate!
  before_action :get_beer, only: [:show]
  before_action :get_beers, only: [:index]
  before_action :get_favorite, only: [:favorite]

  def index
    render json: {
        beers: @beers
    }
  end

  def show
    render json: {
      beer: @beer
    }
  end

  def favorite
    render json: {
      beer: @favorite
    }
  end

  def favorites
    render json: {
      beers: @current_user.all_beers(favorite: true)
    }
  end

  def all
    render json: {
      beers: @current_user.all_beers
    }
  end

  private

  def get_beers
    @beers = Beer.get_beers(beer_name: beer_params['name'], abv: beer_params['abv'], page_number: beer_params['page'])
  end

  def get_beer
    @beer = Beer.get_beer(beer_params['id'], @current_user)
  end

  def get_favorite
    @favorite = UserBeer.favorite_beer(beer_params['id'], @current_user)
  end

  def beer_params
    params.permit(:id, :name, :abv, :page)
  end
end
