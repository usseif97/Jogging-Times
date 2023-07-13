Rails.application.routes.draw do
  resources :jogs do
    collection do
      get 'average_distance'
      get 'average_speed'
      post 'filter'
    end
  end
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'users', to: 'users#index'
  get 'users/:id', to: 'users#show'
  get 'users/role/manager', to: 'users#create_manager'
  get 'users/role/admin', to: 'users#create_admin'
  put 'users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'
end