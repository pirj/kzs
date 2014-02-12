class RenameMailToOfficialMail < ActiveRecord::Migration
  def up
    rename_table :mails, :official_mails
  end

  def down
    rename_table :official_mails, :mails
  end
end
