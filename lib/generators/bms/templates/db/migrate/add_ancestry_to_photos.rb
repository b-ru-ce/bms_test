class AddAncestryToPhotos < ActiveRecord::Migration
  def change
    add_index :photogalleries, :ancestry
    add_index :photos, :ancestry
  end
end
