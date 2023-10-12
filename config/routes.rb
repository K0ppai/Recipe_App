Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :foods, only: %i[new create]

  resources :recipes, only: %i[index show new create destroy] do
    resources :recipes_foods, only: %i[new create destroy]
  end

  resources :inventories do
    resources :inventory_foods, only: %i[new create destroy]
  end
  resources :public_recipes

  get 'inventories/new', to: 'inventories#new'
  post 'inventories/create', to: 'inventories#create'
  get '/shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
  get '/modal', to: 'recipes#modal', as: 'modal'
end
