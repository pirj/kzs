module Documents::OrdersHelper
  # Hides aliases all reports to approved_reports
  def structured_history
    history.map do |order|
      Documents::HistoryOrderDecorator.decorate(order)
    end
  end
end