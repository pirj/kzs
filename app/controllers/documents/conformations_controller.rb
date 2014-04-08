class Documents::ConformationsController < ApplicationController

  def create
    doc = get_document(params)
    if conformation
      if conformed?
        current_user.conform doc, comment: conformation[:comment]
      else
        current_user.deny doc, conformation[:comment]
      end

      respond_to { |format| format.js { render layout: false } }
    end
  rescue Exception => e
    render text: e.message

  # данная строчка добавлена для тестирования работы фронтенда при многократном отсылании голосований
  #respond_to { |format| format.js { render layout: false } }
  end

  private

  def conformed?
    (params[:conformation][:conformed] == 'true')? true : false
  end

  def conformation
    params[:conformation] || nil
  end

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