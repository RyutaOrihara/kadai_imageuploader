Rails.application.routes.draw do
get '/tops', to: 'tops#index'
  resources :blogs do
    collection do
      post :confirm
      resources :users, only: [:new,:create,:show]
      resources :sessions, only:[:new, :create, :destroy]
      resources :favorites,only:[:create,:destroy]

    end
  end
end
