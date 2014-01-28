class AddAncestryToCatalog < ActiveRecord::Migration
  def change
    add_index :categories, :ancestry
    add_index :products, :ancestry
  end
end
