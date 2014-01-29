class AddAncestryToPortfolio < ActiveRecord::Migration
  def change
    add_index :portfolio_objects, :ancestry
  end
end
