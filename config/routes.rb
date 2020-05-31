Rails.application.routes.draw do
  devise_for :users do
    resources :baskets
  end
  root to: 'pages#home'
  get 'restaurants/my_restaurants'
  get 'foods/my_foods'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants do
    resources :foods
  end
end
