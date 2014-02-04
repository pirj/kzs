class DocumentAttachment < ActiveRecord::Base
  attr_accessible :attachment
  belongs_to :document
  has_attached_file :attachment, :styles => { :pdf_thumbnail => ["171x264#", :png] }
end
