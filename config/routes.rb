Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'restaurants/my_restaurants'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants do
    resources :foods
  end
end
