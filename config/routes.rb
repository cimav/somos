Somos::Application.routes.draw do
  root :to => 'home#index'
  match 'home/index' => 'home#index'

  match 'search' => 'search#search'

  match 'g/list' => 'groups#list'
  match 'g/search' => 'groups#search'
  match 'g/:short_name' => 'groups#show'
  match 'g/:id/members' => 'groups#members'
  match 'g/:id/page_list' => 'groups#page_list'
  resources :g, :controller => "groups"

  match 'p/recent/counter/g/:group_id(/:id(.:format))' => 'posts#recent_counter'
  match 'p/recent/counter(/:id(.:format))' => 'posts#recent_counter'
  match 'p/recent/g/:group_id(/:id(.:format))' => 'posts#recent'
  match 'p/recent(.:format)' => 'posts#recent'
  match 'p/recent(/:id(.:format))' => 'posts#recent'
  match 'p/share_form(/:id(.:format))' => 'posts#share_form'
  match 'p/ui(/:id(.:format))' => 'posts#ui'
  match 'p/:id/f/:file_id/:filename' => 'post_files#file', :constraints => { :filename => /[^\/]*/ }
  match 'p/:id/photo/:photo_id/:version/:filename' => 'post_photos#photo', :constraints => { :filename => /[^\/]*/ }
  match 'p/:id/comments/:last' => 'posts#comments'
  match 'p/:id' => 'posts#show'
  resources :posts

  resources :comments

  match 'users/upcoming_birthdays' => 'users#upcoming_birthdays'
  match 'u/menu' => 'users#menu'
  match 'u/logout' => 'users#logout'
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

end
