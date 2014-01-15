class AddAncestryToReviews < ActiveRecord::Migration
  def change
    add_index :reviews, :ancestry
  end
end
