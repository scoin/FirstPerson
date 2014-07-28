Rails.application.routes.draw do

  get '/checkins', to: "users#checkin_points"
  get '/all', to: "quests#all"
  get '/quests', to: "quests#main"
  get '/accept', to: "quests#accept_form"
  get '/accepted', to: "quests#accepted"
  get '/rejected', to: "quests#rejected"
  post '/create', to: "quests#create"
  post '/accept', to: "quests#accept"
  post '/set_location', to: "quests#set_location"

  get '/foursquare', to: "foursquare#index", as: 'foursquare'
  get '/redirect', to: "foursquare#redirect"
  get '/map', to: "foursquare#map", as: "map"
  post '/pull', to: "foursquare#pull", as: 'pull'
  get '/logout', to: "users#logout", as: 'logout'

  devise_for :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'users#index'

  get '/admin-checkin', to: "users#admin_checkin"
  get '/test_login', to: "users#test_login"

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
