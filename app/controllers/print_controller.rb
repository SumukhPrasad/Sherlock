class PrintController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@queue = @current_queue
	end

	def change_quantity
		puts "+1"
		respond_to do |format|
			# Handle a Successful Unfollow
			format.html
			format.js
		end
	end
	helper_method :change_quantity

	def destroy
		@queue = @current_queue
		@queue.destroy
		session[:print_queue_id] = nil
		redirect_to root_path
	end
end
