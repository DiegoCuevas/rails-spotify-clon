Rails.application.routes.draw do
  namespace :api do
    
    resources :songs, only: [:index, :show, :update] do
      get 'artists', on: :member
      get 'albums', on: :member
      # resources :albums, only: [:index]
      get 'search', on: :collection
      patch 'progress', on: :member
      patch 'rating', on: :member
    end

    resources :artists, only: [:index, :show] do
      get "songs", on: :member
      get "albums", on: :member
      get "search", on: :collection
     end 
    
    resources :albums , only: [:index, :show, :update] do
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
