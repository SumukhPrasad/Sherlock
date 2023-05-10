class PrintQueue < ApplicationRecord

	validates_numericality_of :user_id, allow_blank: false, presence: true
		belongs_to :user
		has_many :print_queue_items, dependent: :destroy
end
