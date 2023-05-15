class PrintShopController < ApplicationController
	before_action :authenticate_user!
	def index
		if @current_queue.print_queue_items.empty?
			redirect_to print_path
		end
	end

	def show
		@items = @current_queue.print_queue_items.all
		render :layout => 'printing'
	end
end
