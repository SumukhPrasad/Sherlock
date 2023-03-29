class Section < ApplicationRecord
	include HasBarcode

	validates :sectioncode,  allow_blank: false, presence: true, uniqueness: true
	validates_numericality_of :sectioncode, :less_than_or_equal_to => 9999, :greater_than_or_equal_to => 1
	validates :name, length: {maximum: 50}, allow_blank: false, presence: true
	validates :description, length: {maximum: 100}, allow_blank: false, presence: true

	has_barcode :qr,
		:outputter => :svg,
		:type => :qr_code,
		:value => Proc.new { |s| "SHERLOCK;SECTIONCODE:#{s.sectioncode.to_s.rjust(4, '0')};;RESTOREDATA;NAME:#{(s.name + '*' * 50)[0,50]};DESCRIPTION:#{(s.description + '*' * 100)[0,100]};;" }

	has_many :spaces, dependent: :destroy
	
	def to_param
		sectioncode
	end
end
