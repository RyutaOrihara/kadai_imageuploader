Rails.application.routes.draw do
get '/tops', to: 'tops#index'
  resources :blogs do
    collection do
      post :confirm
    end
  end
end
