class AddURLsToSearchable < ActiveRecord::Migration[7.0]
	def change

		add_column :search_entries, :url, :string

    		Section.all.map{|section| 
			if section.search_entry.present?
				SearchEntry.update(url: Rails.application.routes.url_helpers.section_path(section.sectioncode))
			end
		}
		puts "Updated all sections in DB."

		Space.all.map{|space| 
			if space.search_entry.present?
				SearchEntry.update(url: Rails.application.routes.url_helpers.section_space_path(space.sectioncode_id, space.spacecode))
			end
		}
		puts "Updated all spaces in DB."

		Item.all.map{|item| 
			if item.search_entry.present?
				SearchEntry.update(url: Rails.application.routes.url_helpers.section_space_item_path(item.sectioncode_id, Space.find_by!(:id=>item.spacecode_actual_id).spacecode, item.itemcode))
			end
		}
		puts "Updated all items in DB."
	end
end
