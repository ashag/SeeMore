SeeMore::Application.routes.draw do

  get '/auth/:provider/callback', to: 'sessions#create'

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  get 'user/new' => 'users#new', as: :new_user
  post 'user' => 'users#create'
  get 'user/:id' => 'users#show', as: :show_user
  get 'user/:id/edit' => 'users#edit', as: :edit_user
  put 'user/:id' => 'users#update'
  get 'goodbye' => 'users#goodbye', as: :goodbye
  delete '/user/:id' => 'users#destroy'



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
