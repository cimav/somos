Somos::Application.routes.draw do
  root :to => 'home#index'
  get 'home/index' => 'home#index'

  namespace :admin do
    root :to => 'users#index'
    resources :users
    resources :groups
    resources :applications
    resources :memberships
    resources :user_applications
    get 'users/image/:size/:id' => 'users#image'
  end

  get 'api/auth/:username/:token/:app' => 'api#auth'

  get 'search' => 'search#search'

  resources :sidebar_items

  get 'g/list' => 'groups#list'
  get 'g/search' => 'groups#search'
  get 'g/:short_name' => 'groups#show'
  get 'g/:id/members' => 'groups#members'
  get 'g/:id/page_list' => 'groups#page_list'
  resources :g, :controller => "groups"

  get 'p/recent/counter/g/:group_id(/:id(.:format))' => 'posts#recent_counter'
  get 'p/recent/counter(/:id(.:format))' => 'posts#recent_counter'
  get 'p/recent/g/:group_id(/:id(.:format))' => 'posts#recent'
  get 'p/recent(.:format)' => 'posts#recent'
  get 'p/recent(/:id(.:format))' => 'posts#recent'
  get 'p/past/g/:group_id(/:id(.:format))' => 'posts#past'
  get 'p/past(/:id(.:format))' => 'posts#past'
  get 'p/share_form(/:id(.:format))' => 'posts#share_form'
  get 'p/ui(/:id(.:format))' => 'posts#ui'
  get 'p/:id/f/:file_id/:filename' => 'post_files#file', :constraints => { :filename => /[^\/]*/ }
  get 'p/:id/photo/:photo_id/:version/:filename' => 'post_photos#photo', :constraints => { :filename => /[^\/]*/ }
  get 'p/:id/comments/:last' => 'posts#comments'
  get 'p/:id/like' => 'posts#like'
  get 'p/:id/likers' => 'posts#likers'
  get 'p/:id' => 'posts#show'
  get 'p/delete/:id' => 'posts#mark_as_deleted'
  resources :posts

  get 'comments/delete/:id' => 'comments#mark_as_deleted'
  resources :comments

  get 'users/upcoming_birthdays' => 'users#upcoming_birthdays'
  get 'u/menu' => 'users#menu'
  get 'u/image/:size/:id' => 'users#image'
  resources :users

  resources :pages
  get 'g/:group_id/p/add' => 'pages#add_page'
  get 'g/:group_short_name/:page_short_name' => 'pages#show_group_page'
  get 'pages/:id/update_title' => 'pages#update'
  get 'pages/:id/add_file_section' => 'pages#add_file_section'
  get 'pages/:id/files_section' => 'pages#files_section'
  get 'pages/:id/edit_section/:section_id' => 'pages#edit_section'
  get 'pages/delete/:id' => 'pages#mark_as_deleted'
  get 'pages/mark_as_default/:id' => 'pages#mark_as_default'

  get 'pages_file_sections/delete/:id' => 'page_file_sections#mark_as_deleted'
  resources :page_file_sections

  get 'page_files/reorder' => 'page_files#reorder'
  get 'page_files/:id/file' => 'page_files#file'
  get 'page_files/:id/edit_details' => 'page_files#edit_details'
  get 'pages_files/delete/:id' => 'page_files#mark_as_deleted'
  resources :page_file_sections
  resources :page_files

  get 'events/upcoming' => 'post_events#upcoming'
  get 'events/calendar/:year' => 'post_events#calendar'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get "/logout" => 'sessions#destroy'
  get '/login' => 'login#index'

  get 'editor/link_dialog' => 'editor#link_dialog'
  get 'editor/pages_combo/:id' => 'editor#pages_combo'
  get 'editor/page_files/:id' => 'editor#page_files'

  get ':username' => 'users#profile', :constraints => { :username => /[^\/]*/ }


end
