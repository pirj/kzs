module Documents::OrdersHelper
  # Hides aliases all reports to approved_reports
  def structured_history
    array = []
    history.each do |order|
      array << Documents::ListShowDecorator.decorate(order.document)
      array << Documents::ListShowDecorator.decorate(order.approved_report.document) if order.approved_report
    end

    array
  end

end