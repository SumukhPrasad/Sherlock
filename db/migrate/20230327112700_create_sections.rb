class CreateSections < ActiveRecord::Migration[7.0]
	def change
		create_table :sections do |t|
			t.integer :sectioncode
			t.string :name
			t.text :description
			t.timestamps
		end
		add_index :sections, :sectioncode, :unique => true
	end
end
