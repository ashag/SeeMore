SeeMore::Application.routes.draw do

  root 'welcome#index'
  get '/user/:id'     => 'users#show', as: :show_user

  post '/feeds'       => 'feeds#create',      as: "create_feed"

  get 'search'        => 'feeds#search', :as => 'search'
  post 'feed_search'   => 'feeds#rss_feed', as: 'create_rss'
  # get 'search', to: 'welcome#index'
  get 'results'       => 'welcome#results', as: 'results'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  # for potential future user profile deletion
  # get 'goodbye' => 'users#goodbye', as: :goodbye
  # delete '/user/:id' => 'users#destroy'

  get '/auth/twitter', as: :sign_in
  get '/auth/:provider/callback', to: 'sessions#create'
  post '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'
  get 'sign_out' => 'sessions#destroy', as: :sign_out

end
