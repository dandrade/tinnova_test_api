class Api::V1::BeersController < ApplicationController
  before_action :authenticate!

  def index
    beers = Beers::PunkService.new.retrieve_beers(beer_name: beer_params['name'], abv: beer_params['abv'], page_number: beer_params['page'])
    render json: {
        beers: beers
    }
  end

  private
  def beer_params
    params.permit(:name, :abv, :page)
  end
end
