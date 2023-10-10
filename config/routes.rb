Rails.application.routes.draw do
  resources :foods

  resources :recipes, only: %i[index show new create destroy]
end
