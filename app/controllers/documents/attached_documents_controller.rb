class Documents::AttachedDocumentsController < ApplicationController
  layout 'simple'


  def index
    document = get_document(params)
    @accountable = document.accountable
    attacher = DocumentAttacher.new(document, session)

    # Если пользователь зашел в первый раз или после ухода со страницы без подтверждения,
    #   - удаляем все временные документы (которые пользователь мог добавить в прошлый раз, но не сохранить)
    #   - сбрасываем все метки на удаление (которые пользователь мог поставить в прошлый раз, но не сохранить)
    attacher.clear unless params[:continue]

    # # УДАЛИТЬ
    @to_attach = attacher.pending_attaches 
    @to_detach = attacher.pending_detaches

    # Список текущих (предварительно прикрепленных) документов
    @attached_documents = attacher.attached_documents

    # Список документов, которые в данный момент можно прикрепить
    @attachable_documents = attacher.attachable_documents

    # TODO-justvitalius: этот код нужно восстановить на новых классах.
    # Старый код
    ## Составляем список документов, которые будут показы пользователю как доступные для прикрепления, это:
    ## - по-настоящему прикрепленные документы, если их нет в списке на удаление
    ## - документы в списке на добавление
    ## - сам документ
    #excluded_ids = []
    #excluded_ids.concat real_attached_documents.map {|ad| ad.id unless documents_to_detach.include?(ad.id) }.compact
    #excluded_ids.concat documents_to_attach
    #excluded_ids << document.id
    #
    ## TODO: кроме того, нужно исключить черновики и "подготовленные" документы
    #list_decorator = Documents::ListDecorator
    #each_decorator = Documents::ListShowDecorator
    #attachable_documents = Document.where('id not in (?)', excluded_ids)
    #@attachable_documents = list_decorator.decorate attachable_documents, with: each_decorator
  end

  # На самом деле мы ничего не создаем в БД, создание будет при подтверждении (action confirm)
  def create
    document = get_document(params)    
    attacher = DocumentAttacher.new(document, session)

    attacher.attach(params[:attached_id].to_i)

    # Редирект на index с меткой продолжения операции
    redirect_to polymorphic_path([document.accountable, :attached_documents], params: {continue: true})
  end

  # На самом деле здесь ничего не удаляется, удаление будет происходить при подтверждении (action confirm)
  def destroy
    document = get_document(params)
    attacher = DocumentAttacher.new(document, session)

    attacher.detach params[:id].to_i

    redirect_to polymorphic_path([document.accountable, :attached_documents], params: {continue: true})
  end

  def confirm
    document = get_document(params)
    attacher = DocumentAttacher.new(document, session)

    attacher.confirm    

    redirect_to polymorphic_path(document.accountable)
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
