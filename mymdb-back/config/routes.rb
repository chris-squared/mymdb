Rails.application.routes.draw do
  resources :movies
  get 'movies', controller: :movies, action: :index
  post 'movies', controller: :movies, aciton: :create
  put 'movies/:id', controller: :movies, action: :update
  delete 'movies/:id', controller: :movies, action: :delete

  get 'seen', controller: :movies, action: :seen
  get 'notseen', controller: :movies, action: :notseen
  get 'favorites', controller: :movies, action: :favorites
end
