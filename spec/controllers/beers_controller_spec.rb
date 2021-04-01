require 'rails_helper'

def auth_header
  admin = create(:user)
  token = Auth::JsonWebToken.encode(admin.to_token)
  { 'Authorization': "Bearer #{token}" }
end


RSpec.describe Api::V1::BeersController, type: :controller do

  before(:each) do
    request.headers.merge!(auth_header)
  end

  describe 'index' do

    it 'Retrieve all beers and check if the last is Bad Pixie"' do
      get 'index'
      result = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(result['beers'].last['id']).to eq 25
      expect(result['beers'].last['name']).to eq 'Bad Pixie'
      expect(result['beers'].length).to eq 25
    end

    it 'Retrieve a beer by name"' do
      get 'index', params: { name: 'Prototype 27' }
      result = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(result['beers'].last['id']).to eq 57
      expect(result['beers'].last['name']).to eq 'Prototype 27'
    end

    it 'Retrieve beers with abv 5.2' do
      get 'index', params: { abv: 5.2 }
      result = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)

      expect(result['beers'].length).to eq 12
      expect(result['beers'].first['name']).to eq 'Electric India'
    end

    it 'Tries pagination' do
      get 'index', params: { page: 10 }
      result = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)

      expect(result['beers'].length).to eq 25
      expect(result['beers'].last['abv']).to eq 7.2
    end
  end

  describe 'show' do
    it 'request for beer with id 5' do
      get 'show', params: { id: 5 }
      result = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(result['beer']['id']).to eq 5
      expect(result['beer']['name']).to eq 'Avery Brown Dredge'
    end
  end

  describe 'all beers' do
    it 'gets all stored beers' do
      get 'all'
      result = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(result['beers']).to_not be_nil
    end
  end

  describe 'Favorites' do
    it 'gets all favorites beers' do
      get 'show', params: { id: 25 }
      result = JSON.parse(response.body)
      expect(result['beer']['id']).to eq 25

      get 'favorite', params: { id: 25 }
      result = JSON.parse(response.body)

      get 'favorites'
      result = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(result['beers'][0]['favorite']).to be true
    end
  end

  describe 'Favorite' do
    it 'Choose a favorite beet' do
      # Request  the data
      get 'show', params: { id: 25 }
      result = JSON.parse(response.body)
      expect(result['beer']['id']).to eq 25

      get 'favorite', params: { id: 25 }
      result = JSON.parse(response.body)


      expect(result['beer']['id']).to eq 25
      expect(result['beer']['favorite']).to be true
    end

  end

end