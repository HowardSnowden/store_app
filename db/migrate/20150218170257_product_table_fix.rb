class ProductTableFix < ActiveRecord::Migration
  def up
    create_table "products", primary_key: "id", force: true do |t|
    
    t.string "productCode",          limit: 70,  null: false 
    t.string  "productName",        limit: 70, null: false
    t.string  "productLine",        limit: 50, null: false
    t.string  "productScale",       limit: 10, null: false
    t.string  "productVendor",      limit: 50, null: false
    t.text    "productDescription",            null: false
    t.integer "quantityInStock",    limit: 2,  null: false
    t.float   "buyPrice",                      null: false
    t.float   "MSRP",                          null: false
  
    end
  end
  def down
       drop_table "products"
  
    end
end
