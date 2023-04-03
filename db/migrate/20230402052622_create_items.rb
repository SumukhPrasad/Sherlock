class CreateItems < ActiveRecord::Migration[7.0]
	def change
		create_table :items do |t|
			t.integer :itemcode
			t.string :name
			t.text :description
			t.integer :quantity

			t.integer :sectioncode_id
			t.integer :spacecode_actual_id

			t.timestamps
		end

		add_foreign_key :items, :spaces, column: :spacecode_actual_id, primary_key: :id

		add_index :items, [:spacecode_actual_id, :itemcode], unique: true
	end

end
