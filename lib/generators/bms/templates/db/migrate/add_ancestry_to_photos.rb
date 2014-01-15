class AddAncestryToPhotos < ActiveRecord::Migration
  def change
    add_index :photo_galleries, :ancestry
    add_index :photos, :ancestry
  end
end
