Rails.application.routes.draw do
  devise_for :accounts
  get '/cart', to: 'pages#cart'
  get '/retail-partnership', to: 'pages#retailer', as: 'retailer'
  root to: "pages#home"
end
