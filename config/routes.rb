Somos::Application.routes.draw do
  root :to => 'home#index'
  match 'home/index' => 'home#index'

  match 'api/auth/:username/:token/:app' => 'api#auth'

  match 'search' => 'search#search'

  resources :sidebar_items

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
  match 'p/past/g/:group_id(/:id(.:format))' => 'posts#past'
  match 'p/past(/:id(.:format))' => 'posts#past'
  match 'p/share_form(/:id(.:format))' => 'posts#share_form'
  match 'p/ui(/:id(.:format))' => 'posts#ui'
  match 'p/:id/f/:file_id/:filename' => 'post_files#file', :constraints => { :filename => /[^\/]*/ }
  match 'p/:id/photo/:photo_id/:version/:filename' => 'post_photos#photo', :constraints => { :filename => /[^\/]*/ }
  match 'p/:id/comments/:last' => 'posts#comments'
  match 'p/:id/like' => 'posts#like'
  match 'p/:id/likers' => 'posts#likers'
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
  match 'pages/:id/edit_section/:section_id' => 'pages#edit_section'
  match 'pages/delete/:id' => 'pages#mark_as_deleted'
  match 'pages/mark_as_default/:id' => 'pages#mark_as_default'

  match 'pages_file_sections/delete/:id' => 'page_file_sections#mark_as_deleted'
  resources :page_file_sections

  match 'page_files/reorder' => 'page_files#reorder'
  match 'page_files/:id/file' => 'page_files#file'
  match 'page_files/:id/edit_details' => 'page_files#edit_details'
  match 'pages_files/delete/:id' => 'page_files#mark_as_deleted'
  resources :page_file_sections
  resources :page_files

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
