Rails.application.routes.draw do
  devise_for :users do

  end
  root to: 'pages#home'
   get 'restaurants/my_restaurants'
  get 'foods/my_foods'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :baskets, only: [:new, :create, :edit, :update, :destroy]
  resources :restaurants, only: [:new, :create, :edit, :update, :destroy, :show] do
    resources :foods, only: [:new, :create, :edit, :update, :destroy, :show]
  end


  resources :foods, only: [:index]

  resources :restaurants, only: [:index]


end
