class CreateDatabaseStructure < ActiveRecord::Migration
  def change
    create_table :database_structures do |t|
        ActiveRecord::Schema.define(version: 0) do

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

  add_index "customers", ["salesRepEmployeeNumber"], name: "salesRepEmployeeNumber", using: :btree

  create_table "employees", primary_key: "employeeNumber", force: true do |t|
    t.string  "lastName",   limit: 50,  null: false
    t.string  "firstName",  limit: 50,  null: false
    t.string  "extension",  limit: 10,  null: false
    t.string  "email",      limit: 100, null: false
    t.string  "officeCode", limit: 10,  null: false
    t.integer "reportsTo"
    t.string  "jobTitle",   limit: 50,  null: false
  end

  add_index "employees", ["officeCode"], name: "officeCode", using: :btree
  add_index "employees", ["reportsTo"], name: "reportsTo", using: :btree

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

  create_table "orderdetails", id: false, force: true do |t|
    t.integer "orderNumber",                null: false
    t.string  "productCode",     limit: 15, null: false
    t.integer "quantityOrdered",            null: false
    t.float   "priceEach",                  null: false
    t.integer "orderLineNumber", limit: 2,  null: false
  end

  add_index "orderdetails", ["productCode"], name: "productCode", using: :btree

  create_table "orders", primary_key: "orderNumber", force: true do |t|
    t.date    "orderDate",                 null: false
    t.date    "requiredDate",              null: false
    t.date    "shippedDate"
    t.string  "status",         limit: 15, null: false
    t.text    "comments"
    t.integer "customerNumber",            null: false
  end

  add_index "orders", ["customerNumber"], name: "customerNumber", using: :btree

  create_table "payments", id: false, force: true do |t|
    t.integer "customerNumber",            null: false
    t.string  "checkNumber",    limit: 50, null: false
    t.date    "paymentDate",               null: false
    t.float   "amount",                    null: false
  end

  create_table "productlines", primary_key: "id", force: true do |t|
    t.string "productLine", limit: 70, null: false
    t.string "textDescription", limit: 4000
    t.text   "htmlDescription", limit: 16777215
    t.binary "image",           limit: 16777215
  end

  create_table "products", primary_key: "productCode", force: true do |t|
    t.string  "productName",        limit: 70, null: false
    t.string  "productLine",        limit: 50, null: false
    t.string  "productScale",       limit: 10, null: false
    t.string  "productVendor",      limit: 50, null: false
    t.text    "productDescription",            null: false
    t.integer "quantityInStock",    limit: 2,  null: false
    t.float   "buyPrice",                      null: false
    t.float   "MSRP",                          null: false
  end

  add_index "products", ["productLine"], name: "productLine", using: :btree

end
    end
  end
end
