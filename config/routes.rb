Rails.application.routes.draw do
  resources :transactions
  resources :bank_accounts do
    member do
      put :change_status
    end
  end
  devise_for :users
  root to: "bank_accounts#index"
end
