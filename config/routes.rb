Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    authenticated  do
      root to: 'welcome#index'

    end
    unauthenticated  do
      root 'devise/sessions#new', as: 'unauthenticated_root'
    end

  end

  #index--
  get 'welcome/index'
  get 'welcome/profile'
  #sucursal--
  resources :sucursals
  
  #admin--
  #staff--
  #turno--
  #horario--




end
