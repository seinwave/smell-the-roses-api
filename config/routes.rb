Rails.application.routes.draw do
  get '/signup', to: "users#new"
  resources :users 
  resources :cultivars
  resources :sessions

  root "users#new"
end
