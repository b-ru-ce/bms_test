# -*- encoding : utf-8 -*-
module PhotoGalleriesHelper
  def breadcrumbs
    if @gallery
      res = [{title: @gallery.title}]
      res = children_breadcrumbs(res, Page.purpose('/gallery').first)
    elsif @page
      res = children_breadcrumbs([], @page, true)
    else []
    end

    res << {title: 'Главная', link: '/'}
    res.reverse
  end
end
