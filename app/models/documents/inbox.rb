class Documents::Inbox
  def initialize(current_user, organization, scope = nil)
    @organization = organization
    @user = current_user
    @scope = scope || Document.scoped
  end

  def count
    @count = @scope.inbox(@organization).unread_by(@user).count
  end

  def mail_count
    @mail_count ||=
        @scope.inbox(@organization).mails.unread_by(@user).count
  end

  def order_count
    @order_count ||=
        @scope.inbox(@organization).orders.unread_by(@user).count
  end

  def report_count
    @report_count ||=
        @scope.inbox(@organization).reports.unread_by(@user).count
  end
end