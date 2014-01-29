class AddAncestryToServices < ActiveRecord::Migration
  def change
    add_index :services, :ancestry
  end
end
