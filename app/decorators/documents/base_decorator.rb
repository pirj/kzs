# coding: utf-8
module Documents
  class BaseDecorator < Draper::Decorator
    delegate_all

    def path
      unless object.id.nil?
        h.document_path(object)
      else
        h.new_document_path
      end
    end

    def edit_path
      h.edit_document_path(object)
    end

    # отдает дату в указанном формате
    # obj.date :date_format
    def date *args
      opts = args.extract_options!
      DateFormatter.new(object.date, args.first)
    end


  end
end