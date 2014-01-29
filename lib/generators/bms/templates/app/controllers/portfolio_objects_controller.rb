# -*- encoding : utf-8 -*-
class PortfolioObjectsController < ApplicationController
  def index
    @page = Page.purpose('/portfolio').first
    @portfolio_objects = PortfolioObject.page params[:page]
  end

  def show
    @obj = PortfolioObject.find params[:id]
  end
end
