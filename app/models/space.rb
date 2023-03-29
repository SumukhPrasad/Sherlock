class Space < ApplicationRecord
	include HasBarcode

	validates :spacecode,  allow_blank: false, presence: true, uniqueness: { scope: :sectioncode_id }
	validates_numericality_of :spacecode, :less_than_or_equal_to => 9999, :greater_than_or_equal_to => 1
	validates :name, length: {maximum: 50}, allow_blank: false, presence: true
	validates :description, length: {maximum: 100}, allow_blank: false, presence: true

	has_barcode :qr,
		:outputter => :svg,
		:type => :qr_code,
		:value => Proc.new { |s| "SHERLOCK;SECTIONCODE:#{s.sectioncode_id.to_s.rjust(4, '0')};SPACECODE:#{s.spacecode.to_s.rjust(4, '0')};;RESTOREDATA;NAME:#{(s.name + '*' * 50)[0,50]};DESCRIPTION:#{(s.description + '*' * 100)[0,100]};;" }

		belongs_to :section, foreign_key: :sectioncode_id, primary_key: :sectioncode, required: true

	def to_param
		spacecode
	end
end
