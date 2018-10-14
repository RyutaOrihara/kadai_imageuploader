Rails.application.routes.draw do
  resources :contacts
  get '/tops', to: 'tops#index'

  resources :blogs do
    collection do
      post :confirm
      resources :users, only: [:new,:create,:show]
      resources :sessions, only:[:new, :create, :destroy]
      resources :favorites,only:[:create,:destroy]
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
