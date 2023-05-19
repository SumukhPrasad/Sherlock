class ChangeLegacyItemsToSearchable < ActiveRecord::Migration[7.0]
	def change

		Section.all.map{|section| 
			if !section.search_entry.present?
				SearchEntry.create(name: section.name, searchable: section)
			end
		}
		puts "Updated all legacy sections in DB."

		Space.all.map{|space| 
			if !space.search_entry.present?
				SearchEntry.create(name: space.name, searchable: space)
			end
		}
		puts "Updated all legacy spaces in DB."

		Item.all.map{|item| 
			if !item.search_entry.present?
				SearchEntry.create(name: item.name, searchable: item)
			end
		}
		puts "Updated all legacy items in DB."

	end
end
