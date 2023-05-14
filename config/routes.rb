Rails.application.routes.draw do
	devise_for :users
	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

	resources :sections, param: :sectioncode do
		get "/sections", to: "sections#index"
		member do
			post :add_to_queue
		end
		resources :spaces, param: :spacecode do
			member do
				post :add_to_queue
			end
			resources :items, param: :itemcode do
				post :add_small_to_queue
				post :add_large_to_queue
			end
		end
	end

	get "/print", to: "print#index"
	get 'print_shop', to: "print_shop#index" 

	resources :print_queue_items, only: [] do
		member do
			post :change_quantity
			delete :delete_item
		end
	end

	# Defines the root path route ("/")
	root :controller => 'static', :action => :index
end
