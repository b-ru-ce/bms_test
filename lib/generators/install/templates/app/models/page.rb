# -*- encoding : utf-8 -*-
class Page < ActiveRecord::Base
  include ApplicationHelper
  has_ancestry

  validates :title, presence: true

  default_scope {order('sort')}
  scope :purpose, lambda { |purpose| where(purpose: purpose).limit(1) }
  scope :main_menu,  where(:show_in_menu=>true)

  def path
    {id:id, alias:self.alias}
  end

  def alias
    title.transliterate
  end

  def self.menu_tree
    Page.all.each { |c| c.ancestry = c.ancestry.to_s + (c.ancestry != nil ? "/" : '') + c.id.to_s
    }.sort {|x,y| x.ancestry <=> y.ancestry
    }
  end


  def parent_enum
    #Page.where.not(id: id).order(:names_depth_cache).map { |c| ["-" * (c.depth) + ' ' + c.title, c.id ] }
    Page.menu_tree.map{ |c| ["---" * (c.depth - 1) + ' ' + c.title,c.id]
    }

  end

  def html_title
    title_of_window.to_s.strip.blank? ? (MyConfig.get_config('default_title') + ' - ' + title) : title_of_window
  end

end
