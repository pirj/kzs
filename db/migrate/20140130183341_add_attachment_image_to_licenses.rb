class AddAttachmentImageToLicenses < ActiveRecord::Migration
  def self.up
    change_table :licenses do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :licenses, :image
  end
end
