require 'pp'
class Documents::AttachedDocumentsController < ApplicationController
  layout 'base'

  def index
    document = get_document(params[:official_mail_id])
    @accountable = document.accountable

    initialize_session document.id

    session['documents_to_attach'][document.id] = session['documents_to_attach'][document.id].compact.uniq
    session['documents_to_detach'][document.id] = session['documents_to_detach'][document.id].compact.uniq

    # Пользователь зашел в первый раз или после ухода со страницы без подтверждения
    unless params[:continue]
      # Удаляем все временные документы (которые пользователь мог добавить в прошлый раз, но не сохранить)
      # Сбрасываем все метки на удаление (которые пользователь мог поставить в прошлый раз, но не сохранить)
      session['documents_to_attach'][document.id].clear
      session['documents_to_detach'][document.id].clear      
    end

    # УДАЛИТЬ
    # @params = params
    # @session = session
    @to_attach = defined?(session['documents_to_attach'][document.id]) ? session['documents_to_attach'][document.id].inspect : nil
    @to_detach = defined?(session['documents_to_detach'][document.id]) ? session['documents_to_detach'][document.id].inspect : nil

    # IDs элементов на добавление или удаление
    documents_to_attach = session['documents_to_attach'][document.id]
    documents_to_detach = session['documents_to_detach'][document.id]

    # Уже прикрепленные документы (в БД)
    real_attached_documents = document.attached_documents

    # Список уже прикрепленных документов 
    @attached_documents = real_attached_documents.to_a.map {|ad| ad unless documents_to_detach.include?(ad.id) }.compact
    @attached_documents.concat Document.where('id in (?)', documents_to_attach )

    # Составляем список документов, которые будут показы пользователю как доступные для прикрепления, это:
    # - по-настоящему прикрепленные документы, если их нет в списке на удаление
    # - документы в списке на добавление
    # - сам документ
    excluded_ids = []
    excluded_ids.concat real_attached_documents.map {|ad| ad.id unless documents_to_detach.include?(ad.id) }.compact
    excluded_ids.concat documents_to_attach
    excluded_ids << document.id
    
    # TODO: кроме того, нужно исключить черновики и "подготовленные" документы
    @attachable_documents = Document.where('id > ?', 50).where('id not in (?)', excluded_ids)
  end

  def create
    # На самом деле мы ничего не создаем в БД, создание будет при подтверждении (action confirm)
    # Здесь просто записываем в сессию нужный id
    
    document = get_document(params[:official_mail_id])
    
    # Инициализуем массивы, если они еще не инициализированы
    initialize_session document.id

    documents_to_detach = session['documents_to_detach'][document.id]

    # Если документ есть в списке на удаление - удаляем оттуда
    if documents_to_detach.include? params[:attached_id].to_i
      session['documents_to_detach'][document.id].delete(params[:attached_id].to_i)
    else
      # Иначе, добавляем нужный id в список на добавление
      session['documents_to_attach'][document.id] << params[:attached_id].to_i
    end

    redirect_to documents_official_mail_attached_documents_path(params: {continue: true})
  end

  def destroy
    # На самом деле здесь ничего не удаляется, удаление будет происходить при подтверждении (confirm)
    # Если ID, который мы получили, есть в списке на добавление, просто удаляем его из списка на добавление
    # Если же нет (т.е. это по-настоящему приложенный документ, добавляем его в список на удаление)
    document = get_document(params[:official_mail_id])

    delete_id = params[:id].to_i

    initialize_session document.id

    @attached_documents = document.attached_documents
    attached_ids = @attached_documents.map{|i| i.id.to_i}

    # Если документ по-настоящему приложен - то нужно добавить в список на удаление
    if attached_ids.include? delete_id
      session['documents_to_detach'][document.id] << delete_id   
    elsif session['documents_to_attach'][document.id].include? delete_id # Если же не приложен, но есть в списке на добавление - удаляем из этого списка
      session['documents_to_attach'][document.id].delete(delete_id)
    else
      # Если нет ни там, ни там, нам пришел неверный id - ничего не делаем
    end

    redirect_to documents_official_mail_attached_documents_path(params: {continue: true})
  end

  def confirm
    document = get_document(params[:official_mail_id])

    # IDs элементов на добавление или удаление
    documents_to_attach = session['documents_to_attach'][document.id]
    documents_to_detach = session['documents_to_detach'][document.id]

    document.attached_documents.delete(Document.where('id in (?)', documents_to_detach))
    document.attached_documents.concat Document.where('id in (?)', documents_to_attach )

    redirect_to documents_official_mail_path(document.accountable.id)
  end

private
  def get_document(id)
    Documents::OfficialMail.find(id).document
  end

  def initialize_session doc_id
    session['documents_to_attach'] ||= []
    session['documents_to_attach'][doc_id] ||= []

    session['documents_to_detach'] ||= []
    session['documents_to_detach'][doc_id] ||= []
  end

end
