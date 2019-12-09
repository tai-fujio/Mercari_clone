Rails.application.routes.draw do
  resources :signups, only: [:new] do
    collection do
      get :registration
      get :sms_confirmation
      get :address
      get :payment_method
      get :complete
    end
  end

  get 'users/show'

  devise_for :users
  root 'items#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
