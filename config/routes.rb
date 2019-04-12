Rails.application.routes.draw do
  namespace :api do
    resources :artists, only: [:index, :show] do
      get "songs", on: :member
      get "albums", on: :member
      get "search", on: :collection
     end 
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
    resources :albums
  end 
end
