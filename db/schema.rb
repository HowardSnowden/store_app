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

ActiveRecord::Schema.define(version: 20150403221149) do

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", primary_key: "customerNumber", force: true do |t|
    t.string  "customerName",           limit: 50, null: false
    t.string  "contactLastName",        limit: 50, null: false
    t.string  "contactFirstName",       limit: 50, null: false
    t.string  "phone",                  limit: 50, null: false
    t.string  "addressLine1",           limit: 50, null: false
    t.string  "addressLine2",           limit: 50
    t.string  "city",                   limit: 50, null: false
    t.string  "state",                  limit: 50
    t.string  "postalCode",             limit: 15
    t.string  "country",                limit: 50, null: false
    t.integer "salesRepEmployeeNumber"
    t.float   "creditLimit"
  end

  add_index "customers", ["salesRepEmployeeNumber"], name: "salesRepEmployeeNumber"

  create_table "database_structures", force: true do |t|
  end

  create_table "employees", primary_key: "employeeNumber", force: true do |t|
    t.string  "lastName",   limit: 50,  null: false
    t.string  "firstName",  limit: 50,  null: false
    t.string  "extension",  limit: 10,  null: false
    t.string  "email",      limit: 100, null: false
    t.string  "officeCode", limit: 10,  null: false
    t.integer "reportsTo"
    t.string  "jobTitle",   limit: 50,  null: false
  end

  add_index "employees", ["officeCode"], name: "officeCode"
  add_index "employees", ["reportsTo"], name: "reportsTo"

  create_table "line_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",   default: 1
    t.integer  "order_id"
  end

  create_table "offices", primary_key: "officeCode", force: true do |t|
    t.string "city",         limit: 50, null: false
    t.string "phone",        limit: 50, null: false
    t.string "addressLine1", limit: 50, null: false
    t.string "addressLine2", limit: 50
    t.string "state",        limit: 50
    t.string "country",      limit: 50, null: false
    t.string "postalCode",   limit: 15, null: false
    t.string "territory",    limit: 10, null: false
  end

  create_table "orders", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "email"
    t.string   "pay_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "card_token"
    t.string   "status",     default: "pending"
  end

  create_table "productlines", force: true do |t|
    t.string "productLine",     limit: 70,       null: false
    t.string "textDescription", limit: 4000
    t.text   "htmlDescription", limit: 16777215
    t.binary "image",           limit: 16777215
  end

  create_table "products", force: true do |t|
    t.string  "productCode",        limit: 70, null: false
    t.string  "productName",        limit: 70, null: false
    t.string  "productLine",        limit: 50, null: false
    t.string  "productScale",       limit: 10, null: false
    t.string  "productVendor",      limit: 50, null: false
    t.text    "productDescription",            null: false
    t.integer "quantityInStock",    limit: 2,  null: false
    t.float   "buyPrice",                      null: false
    t.float   "MSRP",                          null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
