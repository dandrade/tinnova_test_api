Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'authentication#login'

      resources :beers, only: [:index, :show] do
        post :favorite, on: :member
        get :favorites, on: :collection
      end
    end
  end
end
