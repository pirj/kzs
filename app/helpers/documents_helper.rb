# coding: utf-8

module DocumentsHelper
  def pdf_to_png(document, width, height)

    #TODO: in production after clear database this code "unless...end" must remove
    unless File.file?("./tmp/document_#{document.id}.pdf")
      pdf = DocumentPdf.new(document, 'show')
      pdf.render_file "tmp/document_#{document.id}.pdf"
      pdf = Magick::Image.read("tmp/document_#{document.id}.pdf").first
      thumb = pdf.scale(400, 520)
      thumb.write "public/system/documents/document_#{document.id}.png"
    end
    image_tag "/system/documents/document_#{document.id}.png", class: 'table-img-md'
  end
end
