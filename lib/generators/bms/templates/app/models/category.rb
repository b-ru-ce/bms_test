# -*- encoding : utf-8 -*-
class Category < ActiveRecord::Base
  include PathWithAlias
  has_ancestry

  validates :title, presence: true

  has_many :products, dependent: :destroy
  accepts_nested_attributes_for :products, :allow_destroy => true

  default_scope {order('sort')}

  def self.menu_tree
    Page.all.each { |c| c.ancestry = c.ancestry.to_s + (c.ancestry != nil ? "/" : '') + c.id.to_s
    }.sort {|x,y| x.ancestry <=> y.ancestry
    }
  end

  def parent_enum
    Category.menu_tree.map{ |c| ["---" * (c.depth - 1) + ' ' + c.title,c.id] }
  end

  def current?(params)
    (params[:id].to_i == id and params[:controller] == 'catalog' and params[:action] == 'show_category') or
        (children.pluck(:id).include?(params[:id].to_i) and params[:controller] == 'catalog' and params[:action] == 'show_category') or
        (products.pluck(:id).include?(params[:id].to_i) and params[:controller] == 'catalog' and params[:action] == 'show_product')
  end
end
