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
  get 'welcome/another_profile/:id', to:'welcome#another_profile', as:'another_profile'
  #sucursal--
  resources :sucursals do
    resources :schedules
    resources :appointments
  end

  get '/appointments/client_appointments/:id',
  to: 'appointments#client_appointments', as: 'client_appointments'
  get '/appointments/staff_appointments/:id',
  to: 'appointments#staff_appointments', as: 'staff_appointments'
  get '/sucursals/:sucursal_id/appointments/:id/edit_serve',
  to: 'appointments#edit_serve', as: 'edit_serve'
  post '/sucursals/:sucursal_id/appointments/:id/update_serve',
  to: 'appointments#update_serve', as: 'update_serve'

  get '*unmatched_route', to: 'application#raise_not_found'


end
