SeeMore::Application.routes.draw do

  root 'welcome#index'
  get  '/user/:id'   => 'users#show',       as: :show_user
  post '/feeds'      => 'feeds#create',     as: 'create_feed'
  get  'search'      => 'feeds#search',     as: 'search'
  post 'feed_search' => 'feeds#rss_feed',   as: 'create_rss'
  get  'results'     => 'welcome#results',  as: 'results'
  get  'sign_out'    => 'sessions#destroy', as: :sign_out
  post 'tweet'       => 'posts#tweet',      as: 'tweet'
  get  '/auth/twitter',                     as: :sign_in
  get  '/auth/:provider/callback',          to: 'sessions#create'
  post '/auth/:provider/callback',          to: 'sessions#create'
  get  '/auth/failure',                     to: 'sessions#failure'

  # This must be the last route listed, or every route afterwards will break
  get  '/:page'      => 'feeds#feed',       as: 'page'
end
