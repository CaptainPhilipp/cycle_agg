Rails.application.routes.draw do
  resources :pricelists, only: %i[new create show]

  # root 'pricelists#index'
end
