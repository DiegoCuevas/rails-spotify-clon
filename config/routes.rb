Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :album , only: [:index, :show, :update] do
      get 'artists', on: :member
      get 'songs', on: :member
      get 'search', on: :collection
      patch 'rating', on: :member
    end
  end

  namespace :admin do
    resources :songs
    resources :artists
  end 
end
