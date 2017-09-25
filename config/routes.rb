Rails.application.routes.draw do
  resources :pricelists, only: %i[new create show]
end
