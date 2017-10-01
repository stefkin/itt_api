Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts, only: [:create, :index]
  resources :ratings, only: [:create]
  resources :multiuser_ips, only: [:index]
end
