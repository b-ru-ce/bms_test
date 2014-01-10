# -*- encoding : utf-8 -*-
module ApplicationHelper
  def html_title(page_title = '')
    if page_title.strip.blank?
      content_for :html_title, (MyConfig.get_config 'default_title')
    else
      content_for :html_title, page_title.to_s
    end

  end

  def html_meta(page_meta)
    content_for :html_meta, page_meta.to_s
  end
end
