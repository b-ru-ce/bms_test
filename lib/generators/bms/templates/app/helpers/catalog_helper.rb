# -*- encoding : utf-8 -*-
module CatalogHelper
  def children_category_breadcrumbs(res, category, first = false)
    hash = {title: category.title}
    hash[:link] = category_path(category.my_path) unless first
    res << hash

    res = children_category_breadcrumbs(res, category.parent) unless category.is_root?
    res
  end

  def breadcrumbs
    if @product
      res = [{title: @product.title}]
      res = children_category_breadcrumbs(res, @product.category)
      res = children_breadcrumbs(res, Page.purpose('/catalog').first)
    elsif @category
      res = children_category_breadcrumbs([], @category, true)
      res = children_breadcrumbs(res, Page.purpose('/catalog').first)
    elsif @page
      res = children_breadcrumbs([], Page.purpose('/catalog').first, true)
    else []
    end

    res << {title: 'Главная', link: '/'}
    res.reverse
  end
end
