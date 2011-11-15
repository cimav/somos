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

ActiveRecord::Schema.define(:version => 20111115040315) do

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.string   "message"
    t.string   "earn_script"
    t.string   "image"
    t.integer  "status",      :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "group_types", :force => true do |t|
    t.string   "name",                         :null => false
    t.string   "description"
    t.integer  "position"
    t.integer  "obligatory",  :default => 1
    t.integer  "can_publish", :default => 1
    t.string   "can_read",    :default => "*"
    t.integer  "status",      :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.integer  "group_type_id"
    t.string   "name",                           :null => false
    t.string   "short_name",                     :null => false
    t.string   "description"
    t.integer  "position"
    t.integer  "can_publish",   :default => 1
    t.string   "can_read",      :default => "*"
    t.integer  "status",        :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["group_type_id"], :name => "index_groups_on_group_type_id"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "can_publish", :default => 1
    t.integer  "can_read",    :default => 1
    t.integer  "can_admin",   :default => 1
    t.integer  "status",      :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["group_id"], :name => "index_memberships_on_group_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "post_files", :force => true do |t|
    t.integer  "post_id"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_files", ["post_id"], :name => "index_post_files_on_post_id"

  create_table "post_links", :force => true do |t|
    t.integer  "post_id"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_links", ["post_id"], :name => "index_post_links_on_post_id"

  create_table "post_types", :force => true do |t|
    t.string   "name",                       :null => false
    t.string   "short_name",                 :null => false
    t.string   "share_title",                :null => false
    t.integer  "in_stream",   :default => 1
    t.integer  "in_pages",    :default => 0
    t.integer  "status",      :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "post_type_id"
    t.text     "content",                     :null => false
    t.integer  "status",       :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["group_id"], :name => "index_posts_on_group_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "user_badges", :force => true do |t|
    t.integer  "user_id"
    t.integer  "badge_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_badges", ["badge_id"], :name => "index_user_badges_on_badge_id"
  add_index "user_badges", ["post_id"], :name => "index_user_badges_on_post_id"
  add_index "user_badges", ["user_id"], :name => "index_user_badges_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username",                  :null => false
    t.string   "first_name",                :null => false
    t.string   "last_name",                 :null => false
    t.string   "occupation"
    t.string   "email",                     :null => false
    t.date     "birth_date"
    t.text     "bio"
    t.string   "image"
    t.integer  "reports_to"
    t.integer  "status",     :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
