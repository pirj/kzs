# coding: utf-8

module DocumentsHelper

  #TODO: @prikha this must be rudimentary. Take a look at next cleanup
  def indox(current_user)
    if current_user.has_permission?(5)
      @count ||= Document.unread.sent_to(current_user.organization_id).count
    else
      @count ||= Document.unread.not_confidential.sent_to(current_user.organization_id).count
    end
    @count
  end

  def pdf_to_png(document, width, height)
    #TODO: in production after clear database this code "unless...end" must remove
    #unless File.file?("./tmp/document_#{document.id}.pdf")
    #  pdf = DocumentPdf.new(document, 'show')
    #  pdf.render_file "tmp/document_#{document.id}.pdf"
    #  pdf = Magick::Image.read("tmp/document_#{document.id}.pdf").first
    #  thumb = pdf.scale(400, 520)
    #  thumb.write "public/system/documents/document_#{document.id}.png"
    #end
    image_tag "/system/documents/document_#{document.id}.png", class: 'table-img-md'
  end
end
