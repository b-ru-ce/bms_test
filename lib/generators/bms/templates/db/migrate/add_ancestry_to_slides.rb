class AddIndexAncestryToSlides < ActiveRecord::Migration
  def change
    add_index :slides, :ancestry
  end
end
