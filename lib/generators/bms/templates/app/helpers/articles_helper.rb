# -*- encoding : utf-8 -*-
module ArticlesHelper
  def breadcrumbs
    if @article
      res = [{title: @article.title}]
      res = children_breadcrumbs(res, Page.purpose('/news').first)
    elsif @page
      res = children_breadcrumbs([], @page, true)
    else []
    end

    res << {title: 'Главная', link: '/'}
    res.reverse
  end
end
