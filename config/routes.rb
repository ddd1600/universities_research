BootstrapRspecLibioCloneApp::Application.routes.draw do
  resources :universities
  resources :users
  root :to => "universities#index"
end
