Rails.application.routes.draw do
  resources :transactions
  resources :bank_accounts
  get 'home/index'
  devise_for :users
  root to: "home#index"
end
