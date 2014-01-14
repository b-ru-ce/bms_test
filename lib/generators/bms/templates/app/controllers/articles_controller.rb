# -*- encoding : utf-8 -*-
class ArticlesController < ApplicationController
  def index
    @articles = Article.page params[:page]
    @page = Page.purpose('/news').first
  end

  def show
    @article = Article.find(params[:id])
  end
end
