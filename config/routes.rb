Rails.application.routes.draw do
  get '/', to: redirect('/users') # TODO: change to redirect('/dashboard')
  # '/signup' 'signup#index'

  resources :users
  resources :signup, only: %i[index]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
