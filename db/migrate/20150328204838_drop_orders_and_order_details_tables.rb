class DropOrdersAndOrderDetailsTables < ActiveRecord::Migration
  def up
      drop_table :orders
      drop_table :orderdetails
      drop_table :payments
  end
 def down
      raise ActiveRecord::IrreversibleMigration
  end
end
