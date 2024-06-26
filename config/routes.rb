Rails.application.routes.draw do
  get 'dashboards/index'
  get 'bookings/index'
  get 'bookings/show'
  get 'spaceships/index'
  get 'spaceships/show'
  devise_for :users
  root "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :spaceships, only: %i[index show new create] do
    resources :bookings, only: %i[create]
    resources :favorites, only: %i[create destroy]
  end
  resources :dashboards, only: [:index]
  resources :bookings, only: [:update]
  resources :notifications, only: [:update]

end
