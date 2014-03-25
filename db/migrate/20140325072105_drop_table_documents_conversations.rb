class DropTableDocumentsConversations < ActiveRecord::Migration
  def up
    drop_table :document_conversations
  end

  def down
    create_table :document_conversations do |t|

      t.timestamps
    end
  end
end
