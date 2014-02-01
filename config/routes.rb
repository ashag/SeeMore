SeeMore::Application.routes.draw do

  root 'welcome#index'
<<<<<<< HEAD
  get '/user/:id'     => 'users#show', as: :show_user

  post '/feeds'       => 'feeds#create',      as: "create_feed"

  get 'search'        => 'feeds#search', :as => 'search'
  post 'feed_search'   => 'feeds#rss_feed', as: 'create_rss'
  # get 'search', to: 'welcome#index'
  get 'results'       => 'welcome#results', as: 'results'
  get 'insta_search' => 'feeds#insta_search', as: 'search_ig'


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

  post 'tweet' => 'posts#tweet', as: 'tweet'
  post 'favorite' => 'posts#favorite', as: 'favorite'

=======
  get  '/user/:id'   => 'users#show',       as: :show_user
  post '/feeds'      => 'feeds#create',     as: 'create_feed'
  get  'search'      => 'feeds#search',     as: 'search'
  post 'feed_search' => 'feeds#rss_feed',   as: 'create_rss'
  get  'results'     => 'welcome#results',  as: 'results'
  get  'sign_out'    => 'sessions#destroy', as: :sign_out
  post 'tweet'       => 'posts#tweet',      as: 'tweet'
  post 'favorite'    => 'posts#favorite',   as: 'favorite'
  post 'retweet'     => 'posts#retweet',    as: 'retweet'
  get  '/auth/twitter',                     as: :sign_in
  get  '/auth/failure',                     to: 'sessions#failure'
  get  '/auth/:provider/callback',          to: 'sessions#create'
  post '/auth/:provider/callback',          to: 'sessions#create'

  # This must be the last route listed, or every route afterwards will break
  get  '/:page',                            to: 'welcome#index'
>>>>>>> ffa9ee7e7c072e712e391e8aa60b4c8ff4b3e396
end
