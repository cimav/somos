Somos::Application.routes.draw do
  root :to => 'home#index'
  match 'home/index' => 'home#index'

  match 'g/list' => 'groups#list'
  match 'g/search' => 'groups#search'
  match 'g/:short_name' => 'groups#show'
  match 'g/:id/members' => 'groups#members'
  match 'g/:id/page_list' => 'groups#page_list'
  resources :g, :controller => "groups"

  match 'posts/recent/counter/g/:group_id(/:id(.:format))' => 'posts#recent_counter'
  match 'posts/recent/counter(/:id(.:format))' => 'posts#recent_counter'
  match 'posts/recent/g/:group_id(/:id(.:format))' => 'posts#recent'
  match 'posts/recent(.:format)' => 'posts#recent'
  match 'posts/recent(/:id(.:format))' => 'posts#recent'
  match 'posts/share_form(/:id(.:format))' => 'posts#share_form'
  match 'posts/ui(/:id(.:format))' => 'posts#ui'
  match 'posts/:id/f/:file_id/:filename' => 'post_files#file', :constraints => { :filename => /[^\/]*/ }
  match 'posts/:id/photo/:photo_id/:version/:filename' => 'post_photos#photo', :constraints => { :filename => /[^\/]*/ }
  match 'posts/:id/comments/:last' => 'posts#comments'
  resources :posts

  resources :comments

  match 'users/upcoming_birthdays' => 'users#upcoming_birthdays'
  resources :users

  resources :pages
  match 'g/:group_id/p/add' => 'pages#add_page'
  match 'g/:group_short_name/:page_short_name' => 'pages#show_group_page'
  match 'pages/:id/update_title' => 'pages#update'

  match 'events/upcoming' => 'post_events#upcoming'

  match '/auth/admin/callback', :to => 'sessions#authenticate'
  match '/auth/failure', :to => 'sessions#failure'

  match ':username' => 'users#profile', :constraints => { :username => /[^\/]*/ }
  match ':username/sidebar' => 'users#sidebar', :constraints => { :username => /[^\/]*/ }


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
