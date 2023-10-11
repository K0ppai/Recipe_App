Rails.application.routes.draw do
  resources :foods
  
  resources :inventories do
    resources :inventory_foods, only: %i[new create destroy]
  end

  get 'inventories/new', to: 'inventories#new'
  post 'inventories/create', to: 'inventories#create'
end
