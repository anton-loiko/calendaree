Rails.application.routes.draw do
  get '/', to: redirect('/users'), as: 'root' # TODO: change to redirect('/dashboard')

  resources :auth, only: %i[index create]
  get '/logout', to: 'auth#logout'

  resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
