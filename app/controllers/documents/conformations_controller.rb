class Documents::ConformationsController < ApplicationController

  def create
    doc = get_document(params)
    render json: params
  end

  private

  def get_document(params)
    if (id = params[:official_mail_id])
      Documents::OfficialMail.find(id).document
    elsif (id = params[:report_id])
      Documents::Report.find(id).document
    elsif (id = params[:order_id])
      Documents::Order.find(id).document
    end
  end

end