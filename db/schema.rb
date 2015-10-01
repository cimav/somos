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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151001143153) do

  create_table "applications", force: :cascade do |t|
    t.string   "short_name", limit: 20
    t.string   "name",       limit: 255
    t.string   "icon",       limit: 255
    t.string   "url",        limit: 255
    t.integer  "app_type",   limit: 4,   default: 1
    t.integer  "status",     limit: 4,   default: 1, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "badges", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "message",     limit: 255
    t.string   "earn_script", limit: 255
    t.string   "image",       limit: 255
    t.integer  "status",      limit: 4,   default: 1
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "content",    limit: 65535
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "status",     limit: 4,     default: 1
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.string   "lat",        limit: 20
    t.string   "long",       limit: 20
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "group_limitations", force: :cascade do |t|
    t.integer  "group_id",    limit: 4
    t.integer  "by_group_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "group_limitations", ["by_group_id"], name: "index_group_limitations_on_by_group_id", using: :btree
  add_index "group_limitations", ["group_id"], name: "index_group_limitations_on_group_id", using: :btree

  create_table "group_types", force: :cascade do |t|
    t.string   "name",        limit: 255,             null: false
    t.string   "description", limit: 255
    t.integer  "position",    limit: 4
    t.integer  "required",    limit: 4,   default: 1
    t.integer  "display_in",  limit: 4,   default: 1
    t.integer  "status",      limit: 4,   default: 1
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer  "group_type_id", limit: 4
    t.string   "name",          limit: 255,             null: false
    t.string   "short_name",    limit: 255,             null: false
    t.string   "description",   limit: 255
    t.integer  "position",      limit: 4
    t.integer  "status",        limit: 4,   default: 1
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "default_page",  limit: 4
    t.string   "limited",       limit: 255
  end

  add_index "groups", ["group_type_id"], name: "index_groups_on_group_type_id", using: :btree
  add_index "groups", ["short_name"], name: "index_groups_on_short_name", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "attachable_id",   limit: 4
    t.string   "attachable_type", limit: 255
    t.integer  "user_id",         limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "group_id",          limit: 4
    t.integer  "can_publish",       limit: 4, default: 1
    t.integer  "can_modify_others", limit: 4, default: 0
    t.integer  "can_admin",         limit: 4, default: 0
    t.integer  "status",            limit: 4, default: 1
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "page_file_sections", force: :cascade do |t|
    t.integer  "page_id",     limit: 4
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "position",    limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "status",      limit: 4
  end

  add_index "page_file_sections", ["page_id"], name: "index_page_file_sections_on_page_id", using: :btree

  create_table "page_files", force: :cascade do |t|
    t.integer  "page_file_section_id", limit: 4
    t.string   "file",                 limit: 255
    t.string   "title",                limit: 255
    t.text     "description",          limit: 65535
    t.integer  "position",             limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "status",               limit: 4
  end

  add_index "page_files", ["page_file_section_id"], name: "index_page_files_on_page_file_section_id", using: :btree

  create_table "page_groups", force: :cascade do |t|
    t.integer  "page_id",    limit: 4
    t.integer  "group_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "page_groups", ["group_id"], name: "index_page_groups_on_group_id", using: :btree
  add_index "page_groups", ["page_id"], name: "index_page_groups_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "group_id",   limit: 4
    t.string   "title",      limit: 255,               null: false
    t.string   "short_name", limit: 255,               null: false
    t.integer  "position",   limit: 4,     default: 1, null: false
    t.text     "content",    limit: 65535
    t.integer  "page_id",    limit: 4
    t.integer  "status",     limit: 4,     default: 1, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "pages", ["group_id"], name: "index_pages_on_group_id", using: :btree
  add_index "pages", ["page_id"], name: "index_pages_on_page_id", using: :btree
  add_index "pages", ["short_name"], name: "index_pages_on_short_name", using: :btree
  add_index "pages", ["user_id"], name: "index_pages_on_user_id", using: :btree

  create_table "post_events", force: :cascade do |t|
    t.integer  "post_id",     limit: 4
    t.string   "title",       limit: 255
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "location",    limit: 65535
    t.text     "information", limit: 65535
    t.string   "link",        limit: 255
    t.string   "image",       limit: 255
    t.string   "lat",         limit: 20
    t.string   "long",        limit: 20
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "post_events", ["post_id"], name: "index_post_events_on_post_id", using: :btree

  create_table "post_files", force: :cascade do |t|
    t.integer  "post_id",    limit: 4
    t.string   "file",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "post_files", ["post_id"], name: "index_post_files_on_post_id", using: :btree

  create_table "post_groups", force: :cascade do |t|
    t.integer  "post_id",    limit: 4
    t.integer  "group_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "post_groups", ["group_id"], name: "index_post_groups_on_group_id", using: :btree
  add_index "post_groups", ["post_id"], name: "index_post_groups_on_post_id", using: :btree

  create_table "post_links", force: :cascade do |t|
    t.integer  "post_id",     limit: 4
    t.string   "link",        limit: 255
    t.text     "description", limit: 65535
    t.string   "image",       limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "post_links", ["post_id"], name: "index_post_links_on_post_id", using: :btree

  create_table "post_photos", force: :cascade do |t|
    t.integer  "post_id",     limit: 4
    t.string   "photo",       limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "post_photos", ["post_id"], name: "index_post_photos_on_post_id", using: :btree

  create_table "post_types", force: :cascade do |t|
    t.string   "name",       limit: 255,             null: false
    t.integer  "category",   limit: 4,   default: 0
    t.integer  "status",     limit: 4,   default: 1
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "post_types", ["name"], name: "index_post_types_on_name", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "group_id",     limit: 4
    t.integer  "post_type_id", limit: 4
    t.text     "content",      limit: 65535,             null: false
    t.string   "limited",      limit: 255
    t.integer  "status",       limit: 4,     default: 1, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "posts", ["group_id"], name: "index_posts_on_group_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "sidebar_item_groups", force: :cascade do |t|
    t.integer  "sidebar_item_id", limit: 4
    t.integer  "group_id",        limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "sidebar_item_groups", ["group_id"], name: "index_sidebar_item_groups_on_group_id", using: :btree
  add_index "sidebar_item_groups", ["sidebar_item_id"], name: "index_sidebar_item_groups_on_sidebar_item_id", using: :btree

  create_table "sidebar_items", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "url",          limit: 255
    t.integer  "position",     limit: 4
    t.integer  "sidebar_type", limit: 4,     default: 1
    t.integer  "status",       limit: 4,     default: 1, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "height",       limit: 255
    t.string   "limited",      limit: 255
    t.text     "content",      limit: 65535
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.string   "lat",        limit: 20
    t.string   "long",       limit: 20
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_applications", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "application_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "user_applications", ["application_id"], name: "index_user_applications_on_application_id", using: :btree
  add_index "user_applications", ["user_id"], name: "index_user_applications_on_user_id", using: :btree

  create_table "user_badges", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "badge_id",   limit: 4
    t.integer  "post_id",    limit: 4
    t.integer  "status",     limit: 4, default: 1
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "user_badges", ["badge_id"], name: "index_user_badges_on_badge_id", using: :btree
  add_index "user_badges", ["post_id"], name: "index_user_badges_on_post_id", using: :btree
  add_index "user_badges", ["user_id"], name: "index_user_badges_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",     limit: 255,               null: false
    t.string   "first_name",   limit: 255,               null: false
    t.string   "last_name",    limit: 255,               null: false
    t.string   "display_name", limit: 255,               null: false
    t.string   "occupation",   limit: 255
    t.string   "email",        limit: 255,               null: false
    t.string   "location",     limit: 255
    t.integer  "reports_to",   limit: 4
    t.text     "bio",          limit: 65535
    t.date     "birth_date"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "address1",     limit: 255
    t.string   "address2",     limit: 255
    t.string   "city",         limit: 255
    t.integer  "state_id",     limit: 4
    t.string   "zip",          limit: 20
    t.integer  "country_id",   limit: 4
    t.string   "phone2",       limit: 20
    t.string   "phone3",       limit: 20
    t.string   "phone1",       limit: 20
    t.string   "website",      limit: 255
    t.string   "lat",          limit: 20
    t.string   "long",         limit: 20
    t.string   "image",        limit: 255
    t.integer  "status",       limit: 4,     default: 1, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "token",        limit: 255
    t.string   "phone1_desc",  limit: 255
    t.string   "phone2_desc",  limit: 255
    t.string   "phone3_desc",  limit: 255
    t.string   "alias",        limit: 255
  end

  add_index "users", ["country_id"], name: "index_users_on_country_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["state_id"], name: "index_users_on_state_id", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  create_table "xxx", id: false, force: :cascade do |t|
    t.integer  "id",           limit: 4,     default: 0, null: false
    t.string   "username",     limit: 255,               null: false
    t.string   "first_name",   limit: 255,               null: false
    t.string   "last_name",    limit: 255,               null: false
    t.string   "display_name", limit: 255,               null: false
    t.string   "occupation",   limit: 255
    t.string   "email",        limit: 255,               null: false
    t.string   "location",     limit: 255
    t.integer  "reports_to",   limit: 4
    t.text     "bio",          limit: 65535
    t.date     "birth_date"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "address1",     limit: 255
    t.string   "address2",     limit: 255
    t.string   "city",         limit: 255
    t.integer  "state_id",     limit: 4
    t.string   "zip",          limit: 20
    t.integer  "country_id",   limit: 4
    t.string   "phone2",       limit: 20
    t.string   "phone3",       limit: 20
    t.string   "phone1",       limit: 20
    t.string   "website",      limit: 255
    t.string   "lat",          limit: 20
    t.string   "long",         limit: 20
    t.string   "image",        limit: 255
    t.integer  "status",       limit: 4,     default: 1, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "token",        limit: 255
    t.string   "phone1_desc",  limit: 255
    t.string   "phone2_desc",  limit: 255
    t.string   "phone3_desc",  limit: 255
  end

end
