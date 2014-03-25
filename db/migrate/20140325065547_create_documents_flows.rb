class CreateDocumentsFlows < ActiveRecord::Migration
  def change
    create_table :documents_flows do |t|

      t.timestamps
    end
  end
end
