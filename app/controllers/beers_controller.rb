class BeersController < ApplicationController
  before_action :authenticate!

  def index
    render json: {
        hello: @current_user.name
    }
  end
end
