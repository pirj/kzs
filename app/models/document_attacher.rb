class DocumentAttacher
  DOCUMENT_TYPES = [Documents::OfficialMail, Documents::Order, Documents::Report]

  attr_reader :pending_attaches
  attr_reader :pending_detaches

  def initialize object, session
    # Принимаем либо Document, либо любые Accountable
    unless is_accountable?(object) || object.kind_of?(Document)
      raise ArgumentError, "Document should be one of #{DOCUMENT_TYPES}, received #{object.class} instead"
    end
    
    # Внутри себя работаем с объектом класса Document, что бы не получили
    @document = is_accountable?(object) ? object.document : object

    @session = session

    @session[:docs_to_attach] ||= []
    @session[:docs_to_attach][@document.id] ||= []
    @session[:docs_to_detach] ||= []
    @session[:docs_to_detach][@document.id] ||= []

    # IDs элементов на добавление или удаление
    @pending_attaches = session[:docs_to_attach][@document.id]
    @pending_detaches = session[:docs_to_detach][@document.id]

    @real_attached_documents = @document.attached_documents
  end

  def attach object
    # Принимаем либо Fixnum (document id), либо Document, либо любые Accountable
    if object && object.is_a?(Numeric)
      id = object
    elsif is_accountable?(object)
      id = object.document.id
    elsif object && object.kind_of?(Document)
      id = object.id
    else
      raise ArgumentError, "Document should be a number, or the one of the #{DOCUMENT_TYPES}, received #{object.class} instead"
    end

    # Если документ есть в списке на удаление - удаляем оттуда
    if @pending_detaches.include? id
      @pending_detaches.delete id
    else 
      # Иначе, добавляем нужный id в список на добавление, если уже не существует
      @pending_attaches << id unless @pending_attaches.include? id
    end
  end
    
  def detach object
    # Принимаем либо Fixnum (document id), либо Document, либо любые Accountable
    if object && object.is_a?(Numeric)
      id = object
    elsif is_accountable?(object)
      id = object.document.id
    elsif object && object.kind_of?(Document)
      id = object.id
    else
      raise ArgumentError, "Document should be a number, or the one of the #{DOCUMENT_TYPES}, received #{object.class} instead"
    end
    
    attached_documents = @document.attached_documents
    attached_ids = attached_documents.map{|i| i.id.to_i}

    if attached_ids.include? id
      # Если документ по-настоящему приложен - то нужно добавить в список на удаление
      @pending_detaches << id
    elsif @pending_attaches.include? id
      # Если же не приложен, но есть в списке на добавление - удаляем из этого списка  
      @pending_attaches.delete(id)
    end
    
    # Если нет ни там, ни там, нам пришел неверный id - ничего не делаем
  end

  # Возвращает документы, доступные для аттача на текущем этапе (для пользователя)
  # TODO: @predetective Refactor to re-use attached_documents() method
  def attachable_documents
    # Составляем список документов, которые будут показы пользователю как доступные для прикрепления, это:
    # - по-настоящему прикрепленные документы, если их нет в списке на удаление
    # - документы в списке на добавление
    # - сам документ
    excluded_ids = []
    excluded_ids.concat @real_attached_documents.map {|ad| ad.id unless @pending_detaches.include?(ad.id) }.compact
    excluded_ids.concat @pending_attaches
    excluded_ids << @document.id
    
    # Кроме того, нужно исключить черновики и "подготовленные" документы
    attachable_documents = Document
                              .where('id not in (?)', excluded_ids)
                              .where('state not in (?)', ['draft','prepared'])
  end

  # Возвращает список уже прикрепленных документов на текущем этапе (для пользователя)
  #  - по-настоящему прикрепленные (в БД) документы, если их нет в списке на удаление
  #  - документы в списке на добавление
  def attached_documents
    attached_documents = @real_attached_documents.to_a.map {|ad| ad unless @pending_detaches.include?(ad.id) }.compact
    attached_documents.concat Document.where('id in (?)', @pending_attaches )
  end

  # Актуализирует данные 
  def confirm
    @document.attached_documents.delete(Document.where('id in (?)', @pending_detaches))
    @document.attached_documents.concat(Document.where('id in (?)', @pending_attaches))
  end

  # Сбрасывает данные
  def clear
    @pending_attaches.clear
    @pending_detaches.clear
  end

private
  # @prdetective TODO: move to helper or smth?
  def is_accountable? obj
    !!DOCUMENT_TYPES.map {|type| obj.kind_of? type}.index(true)
  end
  
end