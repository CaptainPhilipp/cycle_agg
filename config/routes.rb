Rails.application.routes.draw do
  resources :pricelists, only: %i[new create show]
  resources :publications, only: %i[index]

  root 'publications#index'
end
