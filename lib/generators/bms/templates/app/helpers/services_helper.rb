# -*- encoding : utf-8 -*-
module ServicesHelper
  def breadcrumbs
    if @service
      res = [{title: @service.title}]
      res = children_breadcrumbs(res, Page.purpose('/services').first)
    elsif @page
      res = children_breadcrumbs([], @page, true)
    else []
    end

    res << {title: 'Главная', link: '/'}
    res.reverse
  end
end
