class Section < ApplicationRecord

		validates :sectioncode, presence: true, uniqueness: true
		validates :name, presence: true
		validates :description, presence: true

		
		def to_param
					sectioncode
		end
end
