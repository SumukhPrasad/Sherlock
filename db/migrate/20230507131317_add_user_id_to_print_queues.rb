class AddUserIdToPrintQueues < ActiveRecord::Migration[7.0]
  def change
    add_column :print_queues, :user_id, :integer
  end
end