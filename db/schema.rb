# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120827173304) do

  create_table "applications", :force => true do |t|
    t.string   "short_name", :limit => 20
    t.string   "name"
    t.string   "icon"
    t.string   "url"
    t.integer  "app_type",                 :default => 1
    t.integer  "status",                   :default => 1, :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.string   "message"
    t.string   "earn_script"
    t.string   "image"
    t.integer  "status",      :default => 1
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "status",     :default => 1
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "lat",        :limit => 20
    t.string   "long",       :limit => 20
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "group_limitations", :force => true do |t|
    t.integer  "group_id"
    t.integer  "by_group_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "group_limitations", ["by_group_id"], :name => "index_group_limitations_on_by_group_id"
  add_index "group_limitations", ["group_id"], :name => "index_group_limitations_on_group_id"

  create_table "group_types", :force => true do |t|
    t.string   "name",                       :null => false
    t.string   "description"
    t.integer  "position"
    t.integer  "required",    :default => 1
    t.integer  "display_in",  :default => 1
    t.integer  "status",      :default => 1
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "groups", :force => true do |t|
    t.integer  "group_type_id"
    t.string   "name",                         :null => false
    t.string   "short_name",                   :null => false
    t.string   "description"
    t.integer  "position"
    t.integer  "status",        :default => 1
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "default_page"
    t.string   "limited"
  end

  add_index "groups", ["group_type_id"], :name => "index_groups_on_group_type_id"
  add_index "groups", ["short_name"], :name => "index_groups_on_short_name"

  create_table "likes", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "likes", ["user_id"], :name => "index_likes_on_user_id"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "can_publish",       :default => 1
    t.integer  "can_modify_others", :default => 0
    t.integer  "can_admin",         :default => 0
    t.integer  "status",            :default => 1
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "memberships", ["group_id"], :name => "index_memberships_on_group_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "page_file_sections", :force => true do |t|
    t.integer  "page_id"
    t.string   "title"
    t.text     "description"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "status"
  end

  add_index "page_file_sections", ["page_id"], :name => "index_page_file_sections_on_page_id"

  create_table "page_files", :force => true do |t|
    t.integer  "page_file_section_id"
    t.string   "file"
    t.string   "title"
    t.text     "description"
    t.integer  "position"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "status"
  end

  add_index "page_files", ["page_file_section_id"], :name => "index_page_files_on_page_file_section_id"

  create_table "page_groups", :force => true do |t|
    t.integer  "page_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "page_groups", ["group_id"], :name => "index_page_groups_on_group_id"
  add_index "page_groups", ["page_id"], :name => "index_page_groups_on_page_id"

  create_table "pages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "title",                     :null => false
    t.string   "short_name",                :null => false
    t.integer  "position",   :default => 1, :null => false
    t.text     "content"
    t.integer  "page_id"
    t.integer  "status",     :default => 1, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "pages", ["group_id"], :name => "index_pages_on_group_id"
  add_index "pages", ["page_id"], :name => "index_pages_on_page_id"
  add_index "pages", ["short_name"], :name => "index_pages_on_short_name"
  add_index "pages", ["user_id"], :name => "index_pages_on_user_id"

  create_table "post_events", :force => true do |t|
    t.integer  "post_id"
    t.string   "title"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "location"
    t.text     "information"
    t.string   "link"
    t.string   "image"
    t.string   "lat",         :limit => 20
    t.string   "long",        :limit => 20
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "post_events", ["post_id"], :name => "index_post_events_on_post_id"

  create_table "post_files", :force => true do |t|
    t.integer  "post_id"
    t.string   "file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "post_files", ["post_id"], :name => "index_post_files_on_post_id"

  create_table "post_groups", :force => true do |t|
    t.integer  "post_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "post_groups", ["group_id"], :name => "index_post_groups_on_group_id"
  add_index "post_groups", ["post_id"], :name => "index_post_groups_on_post_id"

  create_table "post_links", :force => true do |t|
    t.integer  "post_id"
    t.string   "link"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "post_links", ["post_id"], :name => "index_post_links_on_post_id"

  create_table "post_photos", :force => true do |t|
    t.integer  "post_id"
    t.string   "photo"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "post_photos", ["post_id"], :name => "index_post_photos_on_post_id"

  create_table "post_types", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "category",   :default => 0
    t.integer  "status",     :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "post_types", ["name"], :name => "index_post_types_on_name"

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "post_type_id"
    t.text     "content",                     :null => false
    t.string   "limited"
    t.integer  "status",       :default => 1, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "posts", ["group_id"], :name => "index_posts_on_group_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "sidebar_item_groups", :force => true do |t|
    t.integer  "sidebar_item_id"
    t.integer  "group_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "sidebar_item_groups", ["group_id"], :name => "index_sidebar_item_groups_on_group_id"
  add_index "sidebar_item_groups", ["sidebar_item_id"], :name => "index_sidebar_item_groups_on_sidebar_item_id"

  create_table "sidebar_items", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "position"
    t.integer  "sidebar_type", :default => 1
    t.integer  "status",       :default => 1, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "height"
    t.string   "limited"
    t.text     "content"
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "lat",        :limit => 20
    t.string   "long",       :limit => 20
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "user_applications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "application_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "user_applications", ["application_id"], :name => "index_user_applications_on_application_id"
  add_index "user_applications", ["user_id"], :name => "index_user_applications_on_user_id"

  create_table "user_badges", :force => true do |t|
    t.integer  "user_id"
    t.integer  "badge_id"
    t.integer  "post_id"
    t.integer  "status",     :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "user_badges", ["badge_id"], :name => "index_user_badges_on_badge_id"
  add_index "user_badges", ["post_id"], :name => "index_user_badges_on_post_id"
  add_index "user_badges", ["user_id"], :name => "index_user_badges_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username",                                  :null => false
    t.string   "first_name",                                :null => false
    t.string   "last_name",                                 :null => false
    t.string   "display_name",                              :null => false
    t.string   "occupation"
    t.string   "email",                                     :null => false
    t.string   "location"
    t.integer  "reports_to"
    t.text     "bio"
    t.date     "birth_date"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.integer  "state_id"
    t.string   "zip",          :limit => 20
    t.integer  "country_id"
    t.string   "phone2",       :limit => 20
    t.string   "phone3",       :limit => 20
    t.string   "phone1",       :limit => 20
    t.string   "website"
    t.string   "lat",          :limit => 20
    t.string   "long",         :limit => 20
    t.string   "image"
    t.integer  "status",                     :default => 1, :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "token"
    t.string   "phone1_desc"
    t.string   "phone2_desc"
    t.string   "phone3_desc"
  end

  add_index "users", ["country_id"], :name => "index_users_on_country_id"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["state_id"], :name => "index_users_on_state_id"
  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "xxx", :id => false, :force => true do |t|
    t.integer  "id",                         :default => 0, :null => false
    t.string   "username",                                  :null => false
    t.string   "first_name",                                :null => false
    t.string   "last_name",                                 :null => false
    t.string   "display_name",                              :null => false
    t.string   "occupation"
    t.string   "email",                                     :null => false
    t.string   "location"
    t.integer  "reports_to"
    t.text     "bio"
    t.date     "birth_date"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.integer  "state_id"
    t.string   "zip",          :limit => 20
    t.integer  "country_id"
    t.string   "phone2",       :limit => 20
    t.string   "phone3",       :limit => 20
    t.string   "phone1",       :limit => 20
    t.string   "website"
    t.string   "lat",          :limit => 20
    t.string   "long",         :limit => 20
    t.string   "image"
    t.integer  "status",                     :default => 1, :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "token"
    t.string   "phone1_desc"
    t.string   "phone2_desc"
    t.string   "phone3_desc"
  end

end
