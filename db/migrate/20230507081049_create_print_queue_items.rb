class CreatePrintQueueItems < ActiveRecord::Migration[7.0]
	def change
		create_table :print_queue_items do |t|
			t.string :name
			t.integer :quantity
			t.string :print_content

			t.timestamps
		end
	end
end
