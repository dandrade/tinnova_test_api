class Api::V1::BeersController < ApplicationController
  before_action :authenticate!
  before_action :get_beer, only: [:show]

  def index
    render json: {
        beers: Beers::PunkService.new.retrieve_beers(beer_name: beer_params['name'], abv: beer_params['abv'], page_number: beer_params['page'])
    }
  end

  def show
    render json: {
      beer: @beer
    }
  end

  def favorite
    @beer = UserBeer.favorite_beer(beer_params['id'], @current_user)
    render json: {
      beer: @beer
    }
  end

  private

  def get_beer
    @beer = Beer.get_beer(beer_params['id'], @current_user)
  end

  def beer_params
    params.permit(:id, :name, :abv, :page)
  end
end
