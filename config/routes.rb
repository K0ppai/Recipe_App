Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :foods, only: %i[new create]

  resources :recipes, only: %i[index show new create destroy update] do
    resources :recipes_foods, only: %i[new create destroy]
  end

  resources :inventories, only: %i[index show new create destroy] do
    resources :inventory_foods, only: %i[new create destroy]
  end
  resources :public_recipes, only: %i[index]

  get '/shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
end
