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

ActiveRecord::Schema.define(:version => 20131210064305) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "approve_users", :force => true do |t|
    t.integer  "document_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "car_brands", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "daily_passes", :force => true do |t|
    t.integer  "permit_id"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "id_type"
    t.string   "id_sn"
    t.string   "vehicle"
    t.string   "object"
    t.string   "person"
    t.string   "issued"
    t.date     "date"
    t.string   "guard_duty"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "delete_notices", :force => true do |t|
    t.integer  "user_id"
    t.integer  "document_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "document_attachments", :force => true do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "document_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "document_conversations", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "document_relations", :force => true do |t|
    t.integer "document_id"
    t.integer "relational_document_id"
  end

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "organization_id"
    t.string   "deadline"
    t.text     "text"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.integer  "recipient_id"
    t.boolean  "sent",                     :default => false
    t.integer  "approver_id"
    t.boolean  "approved",                 :default => false
    t.boolean  "opened",                   :default => false
    t.boolean  "for_approve",              :default => false
    t.boolean  "deleted",                  :default => false
    t.boolean  "archived",                 :default => false
    t.boolean  "callback",                 :default => false
    t.boolean  "prepared",                 :default => false
    t.boolean  "draft",                    :default => true
    t.integer  "sender_organization_id"
    t.string   "document_type"
    t.boolean  "with_comments",            :default => false
    t.boolean  "executed",                 :default => false
    t.boolean  "for_confirmation",         :default => false
    t.integer  "project_id"
    t.boolean  "confidential",             :default => false
    t.integer  "executor_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "sn"
    t.datetime "date"
    t.integer  "version",                  :default => 1
    t.integer  "document_conversation_id"
    t.datetime "approved_date"
    t.datetime "sent_date"
    t.datetime "opened_date"
    t.datetime "deteled_date"
    t.datetime "prepared_date"
    t.datetime "executed_date"
  end

  create_table "groups", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "open_notices", :force => true do |t|
    t.integer  "document_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "organizations", :force => true do |t|
    t.string   "title"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "phone"
    t.string   "mail"
    t.integer  "director_id"
    t.integer  "inn"
    t.string   "short_title"
    t.integer  "admin_id"
    t.string   "type_of_ownership"
    t.string   "legal_address"
    t.string   "actual_address"
  end

  create_table "permission_groups", :force => true do |t|
    t.integer  "permission_id"
    t.integer  "group_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "permissions", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "permits", :force => true do |t|
    t.string   "number"
    t.integer  "user_id"
    t.string   "purpose"
    t.date     "start_date"
    t.date     "expiration_date"
    t.string   "requested_duration"
    t.string   "granted_area"
    t.string   "granted_object"
    t.string   "permit_type"
    t.boolean  "agreed",             :default => false
    t.boolean  "canceled",           :default => false
    t.boolean  "released",           :default => false
    t.boolean  "issued",             :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "rejected",           :default => false
    t.integer  "vehicle_id"
    t.string   "permit_class"
    t.boolean  "way_bill"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "responsible_users", :force => true do |t|
    t.integer  "document_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "rights", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "statement_approvers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "statement_id"
    t.boolean  "accepted"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "statements", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "sender_organization_id"
    t.integer  "organization_id"
    t.integer  "document_id"
    t.text     "text"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.boolean  "draft",                  :default => true
    t.boolean  "prepared",               :default => false
    t.boolean  "opened",                 :default => false
    t.boolean  "accepted",               :default => false
    t.boolean  "not_accepted",           :default => false
    t.boolean  "sent",                   :default => false
    t.boolean  "deleted",                :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "approved",               :default => false
    t.datetime "approved_date"
    t.datetime "date"
    t.string   "sn"
    t.integer  "approver_id"
  end

  create_table "task_lists", :force => true do |t|
    t.integer  "statement_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "document_id"
    t.boolean  "completed",    :default => false
  end

  create_table "tasks", :force => true do |t|
    t.integer  "task_list_id"
    t.text     "task"
    t.boolean  "completed",                :default => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.integer  "document_id"
    t.integer  "executor_organization_id"
    t.integer  "sender_organization_id"
    t.datetime "deadline"
    t.integer  "executor_id"
    t.integer  "creator_id"
    t.integer  "approver_id"
    t.text     "executor_comment"
  end

  create_table "user_document_types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_groups", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_permissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "permission_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "user_rights", :force => true do |t|
    t.integer  "user_id"
    t.integer  "right_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.decimal  "phone",                  :precision => 11, :scale => 0
    t.string   "position"
    t.string   "division"
    t.text     "info"
    t.string   "dob"
    t.string   "permit"
    t.datetime "created_at",                                                               :null => false
    t.datetime "updated_at",                                                               :null => false
    t.string   "work_status"
    t.integer  "organization_id"
    t.string   "email",                                                 :default => "",    :null => false
    t.string   "encrypted_password",                                    :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_staff"
    t.boolean  "is_active"
    t.boolean  "is_superuser"
    t.datetime "date_joined"
    t.string   "middle_name"
    t.integer  "id_type"
    t.string   "id_sn"
    t.date     "id_issue_date"
    t.string   "id_issuer"
    t.string   "alt_name"
    t.integer  "permit_id"
    t.boolean  "sys_user",                                              :default => false
  end

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vehicle_users", :force => true do |t|
    t.integer  "vehicle_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "vehicles", :force => true do |t|
    t.string   "brand"
    t.string   "model"
    t.string   "vehicle_body"
    t.string   "register_document"
    t.string   "register_sn"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "permit_id"
    t.integer  "sn_region"
  end

end
