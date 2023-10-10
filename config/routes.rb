Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :foods

  resources :recipes, only: %i[index show new create destroy]

  get '/shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
  get '/modal', to: 'recipes#modal', as: 'modal'
end
