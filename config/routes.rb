BootstrapRspecLibioCloneApp::Application.routes.draw do
  resources :universities
  resources :users
  root :to => "users#index"
end
