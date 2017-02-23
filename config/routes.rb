Rails.application.routes.draw do
  root to: 'artists#index'

  resources :songs, except: [:new, :create]
  resources :artists do
    resources :songs, only: [:new, :create]
  end
  resources :users
  resource :session

end
