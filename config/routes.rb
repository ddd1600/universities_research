BootstrapRspecLibioCloneApp::Application.routes.draw do
  get "screener/index"

  resources :universities
  resources :users
  root :to => "universities#index", :defaults => { :sort => "supply_slope_entering_freshmen", :direction => "asc"  }
end
