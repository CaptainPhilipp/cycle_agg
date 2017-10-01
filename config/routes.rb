Rails.application.routes.draw do
  get 'publications/show'

  resources :pricelists, only: %i[new create show]
  resources :publications, only: %i[index show] do
    get ':group/(:categories)', action: :index, on: :collection, as: :full
  end

  root 'publications#index'
end
