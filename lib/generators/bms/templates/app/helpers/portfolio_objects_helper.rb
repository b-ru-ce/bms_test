# -*- encoding : utf-8 -*-
module PortfolioObjectsHelper
  def breadcrumbs
    if @obj
      res = [{title: @obj.title}]
      res = children_breadcrumbs(res, Page.purpose('/portfolio').first)
    elsif @page
      res = children_breadcrumbs([], @page, true)
    else []
    end

    res << {title: 'Главная', link: '/'}
    res.reverse
  end
end
