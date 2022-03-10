Rails.application.routes.draw do
  resources :players, only: [:index, :create]
  resources :matches, only: :create
end
