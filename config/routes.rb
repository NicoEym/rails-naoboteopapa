Rails.application.routes.draw do
  devise_for :users do

  end
  root to: 'pages#home'
  get 'foods/my_foods'

  resources :foods, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :baskets, only: [:new, :create, :edit, :update, :destroy]
  resources :restaurants do
    resources :foods, only: [:new, :create, :edit, :update, :destroy, :show]
  end
end
