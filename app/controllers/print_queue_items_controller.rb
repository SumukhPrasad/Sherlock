class PrintQueueItemsController < ApplicationController
	before_action :authenticate_user!
		def change_quantity
		@queue = @current_queue

		item = @current_queue.print_queue_items.find_by!(:id => params[:id])		

		item.quantity = params[:quantity]
		item.save
		
		redirect_to print_path
	end
	helper_method :change_quantity

	def delete_item
		@queue = @current_queue

		item = @current_queue.print_queue_items.find_by!(:id => params[:id])		

		item.destroy
		redirect_to print_path
	end
	helper_method :delete_item
end
