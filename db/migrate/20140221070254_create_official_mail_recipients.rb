class CreateOfficialMailRecipients < ActiveRecord::Migration
  def change
    create_table :official_mails_organizations, id: false do |t|
      t.integer :official_mail_id, null: false
      t.integer :organization_id, null: false
    end
    #add_index :official_mail_organizations, [:official_mail_id, :organization_id]
  end
end
