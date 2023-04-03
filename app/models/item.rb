require 'barby/barcode/ean_13'

class Item < ApplicationRecord
		include HasBarcode

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
end
