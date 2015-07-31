class Change < ActiveRecord::Migration
  def up
    create_table "productlines", primary_key: "id", force: true do |t|
    t.string "productLine", limit: 70, null: false
    t.string "textDescription", limit: 4000
    t.text   "htmlDescription", limit: 16777215
    t.binary "image",           limit: 16777215
       end 
    

  end
    def down 
        drop_table "productlines"
        
    end 
end
