Rails.application.routes.draw do
	devise_for :users
	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

	resources :sections, param: :sectioncode do
		get "/sections", to: "sections#index"
		get "/sections/:sectioncode", to: "sections#show"
	end
	# Defines the root path route ("/")
	root :controller => 'static', :action => :index
end
