# frozen_string_literal: true

Rails.application.routes.draw do
  get 'publications/show'

  resources :pricelists, only: %i[new create show]
  resources :publications, only: %i[index show]
  get ':sport_group/(:category)', to: 'publications#index', as: :category

  root 'publications#index'
end
