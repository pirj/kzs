class RenameDocumentAttachments < ActiveRecord::Migration
  def change
    rename_table :document_attachments, :document_attached_files
  end
end
