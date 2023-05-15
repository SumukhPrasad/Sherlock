class PrintQueueItem < ApplicationRecord
	validates_numericality_of :quantity, :greater_than_or_equal_to => 1
	validates_numericality_of :print_queue_id, allow_blank: false, presence: true
	validates :name, allow_blank: false, presence: true
	validates :print_content, allow_blank: false, presence: true
	validates :itemhash, allow_blank: false, presence: true

	belongs_to :print_queue
end
