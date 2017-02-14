Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: {format: :json } do
    scope module: :v1 do
      resources :users, only: [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :lists, only: [:index, :show, :create, :update, :destroy]
      resources :todos, only: [:index, :show, :create, :update, :destroy]
      get    'verify'  => 'sessions#verify_access_token'
    end
  end

end
