# coding: utf-8

module DocumentsHelper

  def doc_user(user_id)
    if User.exists?(user_id)
      User.find(user_id).first_name_with_last_name
    else
      "Deleted"
    end
  end

  def organization(organization_id)
    if Organization.exists?(organization_id)
      Organization.find(organization_id).title
    else
      "Deleted"
    end
  end

  def recipient(document)
    if current_user.organization_id == document.organization_id
      true
    else
      false
    end
  end

  def indox(current_user)
    if current_user.has_permission?(5)
      count = Document.sent.unopened.where(:organization_id => current_user.organization_id).count
    else
      count = Document.sent.unopened.not_confidential.where(:organization_id => current_user.organization_id).count
    end
    count
  end

  def draft(current_user)
    Document.draft.where(:user_id => current_user.id).count
  end

  def to_be_approved(current_user)
    Document.prepared.not_approved.where(:approver_id => current_user.id).count
  end

  def to_be_sent(current_user)
    Document.prepared.approved.not_sent.where(:user_id => current_user.id).count
  end

  def for_approve(document)
    if document.approver_id == current_user.id && document.prepared? && document.approved != true then
      true
    end
  end

  def for_send(document)
    if document.approver_id == current_user.id && document.sent != true && document.approved? || document.user_id == current_user.id && document.sent != true && document.approved? then
      true
    end
  end

  def for_callback(document)
    if document.user_id == current_user.id && document.opened != true && document.sent == true then
      true
    end
  end

  def for_execution(document)
    if action?('execute') == false && @document.for_confirmation == false && @document.statements.present? && @document.organization_id == current_user.organization_id then
      true
    end
  end

  def document_status(document)
    if document.executed?
      '<span class=" label-success btn-available btn" data-toggle="dropdown">Исполнен</span>'.html_safe
    elsif document.with_comments?
      '<span class=" label-warning btn-available btn" data-toggle="dropdown">С замечаниями</span>'.html_safe
    elsif document.for_confirmation?
      '<span class=" label-success btn-available btn" data-toggle="dropdown">Проверка исполнения</span>'.html_safe
    elsif document.opened?
      '<span class=" label-success btn-available btn" data-toggle="dropdown">Получен</span>'.html_safe
    elsif document.sent?
      if document.organization_id == current_user.organization_id
        '<span class=" label-ready btn-available btn" data-toggle="dropdown">Получен</span>'.html_safe
      else
        '<span class=" label-ready btn-available btn" data-toggle="dropdown" data-toggle="dropdown">Отправлен</span>'.html_safe
      end
    elsif document.approved?
      '<span class=" label-warning btn-available btn" data-toggle="dropdown">Подписан</span>'.html_safe
    elsif document.prepared?
      '<span class=" btn-available btn" data-toggle="dropdown">Подготовлен</span>'.html_safe
    elsif document.draft?
      '<span class=" label-inverse btn-available btn" data-toggle="dropdown">Черновик</span>'.html_safe
    else
      nil
    end
  end

  def document_status_date(document)
   # document.date
    if document.executed?
      Russian::strftime(document.executed_date, "%d %B %Y")
    elsif document.opened?
      Russian::strftime(document.opened_date, "%d %B %Y")
    elsif document.sent?
      Russian::strftime(document.sent_date, "%d %B %Y")
    elsif document.approved?
      Russian::strftime(document.approved_date, "%d %B %Y")
    elsif document.prepared?
      Russian::strftime(document.prepared_date, "%d %B %Y")
    elsif document.draft?
      Russian::strftime(document.created_at, "%d %B %Y")
    else
      Russian::strftime(document.date, "%d %B %Y")
    end
  end

  def document_status_progress(document)
    if document.executed?
      100
    elsif document.with_comments?
      90
    elsif document.for_confirmation
      80
    elsif document.opened?
      75
    elsif document.sent?
      50
    elsif document.approved?
      30
    elsif document.prepared?
      20
    elsif document.draft?
      10
    else
      nil
    end
  end

  def document_status_list(document)
    created = content_tag(:li, "Создан - " + Russian::strftime(document.created_at, "%d %B %Y"))
    prepared = content_tag(:li, "Подготовлен - " + Russian::strftime(document.prepared_date, "%d %B %Y")) if document.prepared_date
    approved = content_tag(:li,"Подписан - " + Russian::strftime(document.approved_date, "%d %B %Y")) if document.approved_date
    sent = content_tag(:li,"Отправлен - " + Russian::strftime(document.sent_date, "%d %B %Y")) if document.sent_date
    opened = content_tag(:li,"Открыт - " + Russian::strftime(document.opened_date, "%d %B %Y")) if document.opened_date
    for_confirmation = content_tag(:li,"На проверке - " + Russian::strftime(document.statements.last.approved_date, "%d %B %Y")) if document.statements.present?
   # with_comments =  content_tag(:li,"Вернули с комментариями - " + Russian::strftime(document.with_comments, "%d %B %Y"))
    executed = content_tag(:li,"Исполнено! - " + Russian::strftime(document.executed_date, "%d %B %Y")) if document.executed_date

    if document.executed?
      executed + opened + sent + approved + prepared
    #   elsif document.with_comments
    #     with_comments + opened + sent + approved + prepared
    elsif document.for_confirmation?
      for_confirmation + opened + sent + approved + prepared
    elsif document.opened?
      opened + sent + approved + prepared
    elsif document.sent?
      sent + approved + prepared
    elsif document.approved?
      approved + prepared
    elsif document.prepared?
      prepared
    else
      created
    end

  end

  def pdf_to_png(document, width, height)
    #TODO: in production after clear database this code "unless...end" must remove
    unless File.file?("./tmp/document_#{document.id}.pdf")
      pdf = DocumentPdf.new(document, 'show')
      pdf.render_file "tmp/document_#{document.id}.pdf"
      pdf = Magick::Image.read("tmp/document_#{document.id}.pdf").first
      thumb = pdf.scale(400, 520)
      thumb.write "app/assets/images/document_#{document.id}.png"
    end
    image_tag "document_#{document.id}.png", style: 'background-color: white', size: "#{width}x#{height}" #replace to css
  end
end
