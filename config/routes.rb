Rails.application.routes.draw do
  get 'welcome/index'
  get 'welcome/profile'

  devise_for :users
  devise_scope :user do
    authenticated  do
      root to: 'welcome#index'
      
    end
    unauthenticated  do
      root 'devise/sessions#new', as: 'unauthenticated_root'
    end

  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
