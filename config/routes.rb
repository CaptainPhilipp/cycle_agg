Rails.application.routes.draw do
  resources :pricelists, only: %i[new create]

  # root 'pricelists#index'
end
