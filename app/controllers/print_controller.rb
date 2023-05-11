class PrintController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@queue = @current_queue
	end

	def change_quantity
		@queue = @current_queue
		puts params[:id], params[:quantity]
		
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
