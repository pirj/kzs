class DocumentAttachment < ActiveRecord::Base
  attr_accessible :attachment
  belongs_to :document

  # TODO: it causes an error if the file does not image-type
  #has_attached_file :attachment, :styles => { :pdf_thumbnail => ["171x264#", :png] }

  has_attached_file :attachment
end
