Rails.application.routes.draw do
	devise_for :users
	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

	resources :sections, param: :sectioncode do
		get "/sections", to: "sections#index"
		member do
			post :add_to_queue
		end
		resources :spaces, param: :spacecode do
			resources :items, param: :itemcode
		end
	end

	get "/print", to: "print#index"

	resources :print_queue_items, only: [] do
		member do
			post :change_quantity
			delete :delete_item
		end
	end

	# Defines the root path route ("/")
	root :controller => 'static', :action => :index
end
