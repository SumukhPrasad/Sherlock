class CreateSpaces < ActiveRecord::Migration[7.0]
	def change
		create_table :spaces do |t|
			t.integer :spacecode
			t.string :name
			t.text :description
			t.references :sectioncode, foreign_key: {to_table: :sections}
			t.timestamps
		end

		add_index :spaces, [:sectioncode_id, :spacecode], unique: true
	end
	def self.down
		drop_table :spaces
	end
end
