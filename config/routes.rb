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
  match 'p/delete/:id' => 'posts#mark_as_deleted'
  resources :posts

  match 'comments/delete/:id' => 'comments#mark_as_deleted'
  resources :comments

  match 'users/upcoming_birthdays' => 'users#upcoming_birthdays'
  match 'u/menu' => 'users#menu'
  resources :users

  resources :pages
  match 'g/:group_id/p/add' => 'pages#add_page'
  match 'g/:group_short_name/:page_short_name' => 'pages#show_group_page'
  match 'pages/:id/update_title' => 'pages#update'
  match 'pages/:id/add_file_section' => 'pages#add_file_section'
  match 'pages/:id/files_section' => 'pages#files_section'

  match 'events/upcoming' => 'post_events#upcoming'

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  match "/logout" => 'sessions#destroy'
  match '/login' => 'login#index'

  match 'editor/link_dialog' => 'editor#link_dialog'
  match 'editor/pages_combo/:id' => 'editor#pages_combo'
  match 'editor/page_files/:id' => 'editor#page_files'

  match ':username' => 'users#profile', :constraints => { :username => /[^\/]*/ }
  match ':username/sidebar' => 'users#sidebar', :constraints => { :username => /[^\/]*/ }


end
