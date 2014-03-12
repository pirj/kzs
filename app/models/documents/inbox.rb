class Documents::Inbox
  def initialize(current_user, organization, scope = nil)
    @organization = organization
    @user = current_user
    @scope = scope || Document.scoped
  end

  def count
    @count = incoming.count
  end

  # Accepts :orders, :mails, :reports in
  # symbols or strings
  def count_by_type(type)
    type = type.to_s
    case type
      when 'orders' then order_count
      when 'mails' then mail_count
      when 'reports' then report_count
      else
        count
    end
  end

  def mail_count
    @mail_count ||=
        incoming.mails.count
  end

  def order_count
    @order_count ||=
        incoming.orders.count
  end

  def report_count
    @report_count ||=
        incoming.reports.count
  end
  
  def incoming
    @scope.inbox(@organization).unread_by(@user)
  end

end