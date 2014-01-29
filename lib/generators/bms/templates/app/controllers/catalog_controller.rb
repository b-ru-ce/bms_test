# -*- encoding : utf-8 -*-
class CatalogController < ApplicationController
  def index
    @categories = Category.all
    @page = Page.purpose('/catalog').first
  end

  def show_category
    @category = Category.find params[:id]

    categories_ids = @category.has_children? ? ([@category.id] + @category.children.pluck(:id)) : [@category.id]
    @products = Product.where(category_id: categories_ids)
    @products = @products.reorder("#{product_sort_params.include?(params[:order]) ? params[:order] : 'price'} #{params[:direction] == 'asc' ? 'asc' : 'desc'}") if params[:order]
    @products = @products.where('price >= ?', params[:price_from]) if params[:price_from] and params[:price_from] != ''
    @products = @products.where('price <= ?', params[:price_to]) if params[:price_to] and params[:price_to] != ''
    @products = @products.page params[:page]
  end

  def show_product
    @product = Product.find params[:id]
  end

  private
  def product_sort_params
    ['price']
  end
end
