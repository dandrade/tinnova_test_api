module Beers
  class PunkService
    API_ENDPOINT = "https://api.punkapi.com/v2/beers"

    def initialize
      @punk = Faraday.new(url: API_ENDPOINT)
    end

    def retrieve_beers(beer_name: nil, abv: nil, page_number: nil)
      params = { page: page_number || 1  }
      params[:beer_name] = beer_name if beer_name.present?
      params.merge!(abv_lt: (abv.to_f + 0.1), abv_gt: (abv.to_f - 0.1)) if abv.present?

      request = @punk.get '', params

      parse_response(request.body)
    end

    def parse_response(response)
      parser = JSON.parse(response)
      parser.map{ |beer| beer.slice("id","name", "tagline", "description", "abv")}
    end
  end
end