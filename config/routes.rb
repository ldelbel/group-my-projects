Rails.application.routes.draw do
  resources :users
  resources :groups
  resources :projects

  root to: 'users#index'
end
