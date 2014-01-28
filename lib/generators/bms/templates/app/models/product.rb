# -*- encoding : utf-8 -*-
class Product < ActiveRecord::Base
  include PathWithAlias
  dragonfly_accessor :image

  has_ancestry

  paginates_per 10

  belongs_to :category

  validates :title, presence: true

  default_scope {order('sort')}

  def my_path
    {id: self.id, alias: self.alias, category_alias: category.alias}
  end
end