SeeMore::Application.routes.draw do

  root 'welcome#index'
  get '/user/:id' => 'users#show', as: :show_user


  get 'search' => 'application#search', :as => 'search'
  # get 'search', to: 'welcome#index'
  get 'results' => 'welcome#results', as: 'results'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  # for potential future user profile deletion
  # get 'goodbye' => 'users#goodbye', as: :goodbye
  # delete '/user/:id' => 'users#destroy'
  
  get '/auth/:provider/callback', to: 'sessions#create'
  post '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'
  get 'sign_out' => 'sessions#destroy', as: :sign_out
  get '/signin' => 'welcome#signin', as: :signin

end
