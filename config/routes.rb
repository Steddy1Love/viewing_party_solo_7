Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  get '/users/:id/discover', to: 'users#discover', as: 'user_discover'

  post '/search', to: 'users#search'

  resources :users, only: [:show, :create] do
  end

end