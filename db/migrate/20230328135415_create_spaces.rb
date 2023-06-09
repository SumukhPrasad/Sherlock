class CreateSpaces < ActiveRecord::Migration[7.0]
	def change
		create_table :spaces do |t|
			t.integer :spacecode
			t.string :name
			t.text :description
			t.integer :sectioncode_id
			t.timestamps
		end
		add_foreign_key :spaces, :sections, column: :sectioncode_id, primary_key: :sectioncode
		add_index :spaces, [:sectioncode_id, :spacecode], unique: true
	end
	def self.down
		drop_table :spaces
	end
end
