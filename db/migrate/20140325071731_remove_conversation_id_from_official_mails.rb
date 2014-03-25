class RemoveConversationIdFromOfficialMails < ActiveRecord::Migration
  def up
    remove_column :official_mails, :conversation_id
  end

  def down
    add_column :official_mails, :conversation_id, :string
  end
end
