# -*- encoding : utf-8 -*-
class PhotoGalleriesController < ApplicationController
  def index
    @galleries = PhotoGallery.all

    if @galleries.length == 1
      @gallery = PhotoGallery.first
      render 'show'
    else
      render 'index'
    end
  end

  def show
    @gallery = PhotoGallery.find(params[:id])
  end
end
