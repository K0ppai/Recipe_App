Rails.application.routes.draw do
  resources :foods

  resources :recipes, only: %i[index show new create destroy] do
    resources :recipes_foods, only: %i[new create]
  end

  get "/shopping_list", to: "recipes#shopping_list", as: "shopping_list"
  get "/modal", to: "recipes#modal", as: "modal"
end
