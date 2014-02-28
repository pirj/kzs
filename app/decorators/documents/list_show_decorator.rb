# coding: utf-8
module Documents
  class ListShowDecorator < Documents::BaseDecorator
    decorates :document
    delegate :title




    def title_link
      if object.title
        h.link_to object.title, path, class: 'link'
      end
    end



    def number_and_date
      if object.approved_at
        h.content_tag :span, DateFormatter.new(object.approved_at)
      else
        ""
      end

      #if object.sn || object.date
      #  h.content_tag( :b, object.sn )+
      #  h.content_tag( :span, " / #{object.date}", class: 'muted' )
      #end
    end




    # define two same links with for Organization model.
    %w(sender recipient).each do |attr|
      define_method "#{attr}_link" do
        if object.send(attr)
          h.link_to( object.send(attr).try(:title), h.organization_path(object.send(attr)), class: "link")
        else
          h.link_to( object.accountable.recipients.first.try(:title), '#', class: "link") if object.accountable_type == 'Documents::OfficialMail'
        end
      end
    end


    def attachment_icon
      if object.document_attachments.length > 0
        h.content_tag :span, nil, class: 'fa fa-paperclip icon'
      end
    end

    def attachments_count_with_label
      element_wrapper object.document_attachments.length > 0 do
        h.content_tag(:span, I18n.t("documents.table.document_labels.attachments_count"), class: "text-help col-sm-#{LABEL_COL_WIDTH}")+
        h.content_tag( :span, object.document_attachments.try(:count), class: "link col-sm-#{12-LABEL_COL_WIDTH}")
      end
    end


  end
end