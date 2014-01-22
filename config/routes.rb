SeeMore::Application.routes.draw do

  root 'welcome#index'

  # for potential future user profile deletion
  # get 'goodbye' => 'users#goodbye', as: :goodbye
  # delete '/user/:id' => 'users#destroy'
  
  get '/auth/:provider/callback', to: 'sessions#create'
  post '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'


end
