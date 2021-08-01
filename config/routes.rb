Rails.application.routes.draw do
  devise_for :accounts

  post 'checkout/purchase', to: 'checkout#create'

  resources :webhooks, only: [:create]

  resources :products
  get '/wines', to: 'products#wines'
  get '/wines/:id', to: 'products#show', as: 'wine'

  get '/checkout/success', to: 'checkout#success'
  get '/checkout/cancel', to: 'checkout#cancel'

  get '/cart', to: 'pages#cart'
  get '/retail-partnership', to: 'pages#retailer', as: 'retailer'
  root to: "pages#home"
end
