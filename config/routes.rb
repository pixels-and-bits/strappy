  root :to => 'home#index'

  match 'admin',
    :as => :admin,
    :to => 'admin/base#index'

  match 'login',
    :as => :login,
    :to => 'user_sessions#new'

  match 'logout',
    :as => :logout,
    :to => 'user_sessions#destroy'

  match 'signup',
    :as => :signup,
    :to => 'users#new'

  match 'forgot_password',
    :as => :forgot_password,
    :to => 'password_reset#new'

  resource :account, :controller => "users"
  resource :user_session

  resources :password_reset
  resources :users
