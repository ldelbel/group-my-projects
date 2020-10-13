Rails.application.routes.draw do
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  
  resources :users, only: %i[index show edit update new create]
  resources :groups
  resources :projects, only: %i[index show update new create destroy]

  root to: 'application#home'
end
