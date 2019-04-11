Rails.application.routes.draw do
  namespace :admin do
    resources :songs
end 
end
