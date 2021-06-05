Rails.application.routes.draw do
  resources :transactions
  resources :bank_accounts
  devise_for :users
  root to: "bank_accounts#index"
end
