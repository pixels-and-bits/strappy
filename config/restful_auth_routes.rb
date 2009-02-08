# Restful Authentication Routes
  map.logout '/logout', 
    :controller => 'sessions', 
    :action => 'destroy'

  map.login '/login', 
    :controller => 'sessions', 
    :action => 'new'

  map.register '/register', 
    :controller => 'users', 
    :action => 'create'

  map.signup '/signup', 
    :controller => 'users', 
    :action => 'new'

  map.activate '/activate/:activation_code', 
    :controller => 'users', 
    :action => 'activate', 
    :activation_code => nil

  # Restful Authentication Resources
  map.resources :users
  map.resources :passwords
  map.resource  :session
