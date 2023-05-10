class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :current_queue

	private
		def current_queue
			unless current_user.nil?
				if current_user.print_queue == nil
					current_user.print_queue = PrintQueue.create
					@current_queue = current_user.print_queue
				else
					@current_queue = current_user.print_queue
				end
				puts @current_queue
			end
		end
		# if session[:print_queue_id]
		# 	queue = PrintQueue.find_by(:id => session[:print_queue_id])
		# 	if queue.present?
		# 		@current_queue = queue
		# 	else
		# 		session[:print_queue_id] = nil
		# 	end
		# end
# 
		# if session[:print_queue_id] == nil
		# 	@current_queue = PrintQueue.create
		# 	session[:print_queue_id] = @current_queue.id
		# end

	protected
		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
			devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :password_confirmation) }
		end
end
