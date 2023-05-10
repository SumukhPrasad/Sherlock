class CreatePrintQueues < ActiveRecord::Migration[7.0]
	def change
		create_table :print_queues do |t|

			t.timestamps
		end
	end
end
