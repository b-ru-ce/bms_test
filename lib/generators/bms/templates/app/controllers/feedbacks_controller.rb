# -*- encoding : utf-8 -*-
class FeedbacksController < ApplicationController
  def new
    @page = Page.purpose('/contacts').first
    @feedback = Feedback.new
  end

  def create
    f = Feedback.new feedback_params

    if f.save
      MyMailer.feedback(f).deliver
      render :text => 'ok'
    else
      render :status => :unprocessable_entity
    end
  end

  private
  def feedback_params
    params.require(:feedback).permit(:name, :phone, :email, :theme, :text)
  end
end
