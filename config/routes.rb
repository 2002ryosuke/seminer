Rails.application.routes.draw do
  # get 'lines/index'
  # get 'lines/create'
  # get 'lines/destory'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "points#index"
  get "points/detail", to: 'points#detail'
  get "points/side_distance", to: 'points#side_distance'
  resources :points, only: [:index, :create, :destroy]
  # delete 'points/:id', to: 'points#destroy'
  resources :lines, only: [:create]
end
