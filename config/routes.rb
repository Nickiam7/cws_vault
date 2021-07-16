Rails.application.routes.draw do
  devise_for :accounts

  resources :wines

  post 'checkout/purchase', to: 'checkout#create'
  get '/cart', to: 'pages#cart'
  get '/retail-partnership', to: 'pages#retailer', as: 'retailer'
  root to: "pages#home"
end
