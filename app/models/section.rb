class Section < ApplicationRecord
	include HasBarcode
	include Searchable

	validates :sectioncode,  allow_blank: false, presence: true, uniqueness: true
	validates_numericality_of :sectioncode, :less_than_or_equal_to => 9999, :greater_than_or_equal_to => 1
	validates :name, length: {maximum: 50}, allow_blank: false, presence: true
	validates :description, length: {maximum: 100}, allow_blank: false, presence: true

	has_barcode :qr,
		:outputter => :svg,
		:type => :qr_code,
		:value => Proc.new { |s| "SHERLOCK;SECTIONCODE:#{s.sectioncode.to_s.rjust(4, '0')};;RESTOREDATA;NAME:#{(s.name + '*' * 50)[0,50]};DESCRIPTION:#{(s.description + '*' * 100)[0,100]};;" }

	has_many :spaces, foreign_key: :sectioncode_id, primary_key: :sectioncode, dependent: :destroy
	has_many :items, through: :spaces, foreign_key: :sectioncode_id, primary_key: :sectioncode, dependent: :destroy
	def to_param
		sectioncode
	end

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
