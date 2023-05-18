require 'barby/barcode/ean_13'

class Item < ApplicationRecord
	include HasBarcode
	include Searchable

	validates :itemcode,  allow_blank: false, presence: true, uniqueness: { scope: :spacecode_actual_id }
	validates_numericality_of :itemcode, :less_than_or_equal_to => 9999, :greater_than_or_equal_to => 1

		validates :name, length: {maximum: 50}, allow_blank: false, presence: true
	validates :description, length: {maximum: 100}, allow_blank: false, presence: true
		validates :quantity,  allow_blank: false, presence: true
	validates_numericality_of :quantity, :greater_than_or_equal_to => 1

	has_barcode :barcode,
				:outputter => :svg,
				:type => Barby::EAN13,
				:value => Proc.new { |s| "#{s.sectioncode_id.to_s.rjust(4, '0')}#{Space.find_by(id: s.spacecode_actual_id).spacecode.to_s.rjust(4, '0')}#{s.itemcode.to_s.rjust(4, '0')}" }

	belongs_to :space, foreign_key: :spacecode_actual_id, primary_key: :spacecode, required: true

	after_commit :create_search_entry, on: :create
	after_commit :update_search_entry, on: :update
	after_commit :destroy_search_entry, on: :destroy

	private
		def create_search_entry
			SearchEntry.create(name: self.name, searchable: self)
		end

		def update_search_entry
			if self.search_entry.present?
				self.search_entry.update(name: self.name)
			else
				SearchEntry.create(name: self.name, searchable: self)
			end
		end

		def destroy_search_entry
			self.search_entry.destroy if self.search_entry.present?
		end
end
