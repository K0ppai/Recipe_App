Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :foods, only: %i[new create]

  resources :recipes, only: %i[index show new create destroy] do
    resources :recipes_foods, only: %i[new create destroy]

  resources :inventories do
    resources :inventory_foods, only: %i[new create destroy]
  end

  get 'inventories/new', to: 'inventories#new'
  post 'inventories/create', to: 'inventories#create'
end
