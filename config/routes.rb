Rails.application.routes.draw do
  get 'publications/show'

  resources :pricelists, only: %i[new create show]
  resources :publications, only: %i[index show]
  get ':group/(:categories)', to: 'publications#index', as: :category

  root 'publications#index'
end
