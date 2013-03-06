BootstrapRspecLibioCloneApp::Application.routes.draw do
  resources :universities
  resources :users
  root :to => "universities#index", :defaults => { :sort => "research_exp_per_person_2011", :direction => "desc"  }
end
