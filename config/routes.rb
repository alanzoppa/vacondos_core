Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #devise_for :admin
  resources :homes, only: [:index, :show]
  root to: "home#index"
end
