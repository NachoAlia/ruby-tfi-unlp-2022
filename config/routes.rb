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

  get 'welcome/index'
  get 'welcome/profile'
  get 'welcome/another_profile/:id', to:'welcome#another_profile', as:'another_profile'

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


  get '/admins/index', to:'admins#index', as:'admins'
  get '/admins/users', to:'admins#users', as:'admins_users'
  get '/admins/clients', to:'admins#clients', as:'admins_clients'
  get '/admins/new_user', to:'admins#new_user', as:'admins_new_user'
  get '/admins/edit_user', to:'admins#edit_user', as:'admins_edit_user'
  post '/admins/create_user', to:'admins#create_user', as:'admins_create_user'
  post '/admins/update_user', to:'admins#update_user', as:'admins_update_user'
  delete '/admins/user_destroy/:id', to:'admins#user_destroy', as:'admins_user_destroy'

  get '*unmatched_route', to: 'application#raise_not_found'
end
