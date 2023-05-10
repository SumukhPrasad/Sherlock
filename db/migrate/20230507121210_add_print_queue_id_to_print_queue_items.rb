class AddPrintQueueIdToPrintQueueItems < ActiveRecord::Migration[7.0]
  def change
    add_column :print_queue_items, :print_queue_id, :integer
  end
end
