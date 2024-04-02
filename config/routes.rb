Rails.application.routes.draw do
  get 'pages/about'
  get 'pages/contact'

  root to: 'products#index'

  get 'products/index'

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  resources :products, only: [:show, :index]
  resources :product_categories, only: [:index,:show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
