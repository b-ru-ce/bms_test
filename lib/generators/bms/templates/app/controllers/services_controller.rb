# -*- encoding : utf-8 -*-
class ServicesController < ApplicationController
  def index
    @page = Page.purpose('/services').first
    @services = Service.page params[:page]
  end

  def show
    @service = Service.find params[:id]
  end
end
