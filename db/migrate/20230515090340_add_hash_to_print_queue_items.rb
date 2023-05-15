class AddHashToPrintQueueItems < ActiveRecord::Migration[7.0]
  def change
    add_column :print_queue_items, :itemhash, :string
  end
end
