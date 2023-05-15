class SpacesController < ApplicationController
	before_action :authenticate_user!
	def index
		@section = Section.find_by!(:sectioncode => params[:section_sectioncode])
		@spaces = Space.where(:sectioncode_id => params[:section_sectioncode])
	end
	def show
		@section = Section.find_by!(:sectioncode => params[:section_sectioncode])
		@space = Space.find_by!(:sectioncode_id => params[:section_sectioncode], :spacecode => params[:spacecode])
	end

	def new
		@section = Section.find_by!(:sectioncode => params[:section_sectioncode])
		@space = Space.new
	end
	
	def create
		@space = Space.new(space_params)
		@section = Section.find_by!(:sectioncode => params[:section_sectioncode])
		@space.sectioncode_id = params[:section_sectioncode]
		if @space.save
			redirect_to section_space_path(@space.sectioncode_id, @space.spacecode)
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
		@space = Space.find_by!(:sectioncode_id => params[:section_sectioncode], :spacecode => params[:spacecode])
		@section = Section.find_by!(:sectioncode => params[:section_sectioncode])
		@backpath = section_space_path(@space.sectioncode_id, @space.spacecode)
		@name = @space.name
	end
	
	def update
		@space = Space.find_by!(:sectioncode_id => params[:section_sectioncode], :spacecode => params[:spacecode])
		@section = Section.find_by!(:sectioncode => params[:section_sectioncode])
		@backpath = section_space_path(@space.sectioncode_id, @space.spacecode)
		@name = @space.name
		if @space.update(space_params)
			redirect_to section_space_path(@space.sectioncode_id, @space.spacecode)
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def add_to_queue
		@space = Space.find_by!(:sectioncode_id => params[:section_sectioncode], :spacecode => params[:spacecode])
		@section = Section.find_by!(:sectioncode => params[:section_sectioncode])

		printString = "Space Label for #{@space.name} of section #{@section.name}"
		if @current_queue.print_queue_items.find_by(:itemhash => Digest::SHA256.hexdigest(printString)) != nil
			printItem = @current_queue.print_queue_items.find_by(:itemhash => Digest::SHA256.hexdigest(printString))
			printItem.quantity += 1
			printItem.print_content = render("_label", locals: { space: @space }, :layout => false)
			printItem.save!
		else
			printItem = @current_queue.print_queue_items.new(:name => printString, :itemhash => Digest::SHA256.hexdigest(printString), :quantity => 1, :print_content => render("_label", locals: { space: @space }, :layout => false))
			printItem.save!
		end

		

		respond_to do |format|
			format.html
			format.js
		end
	end

	helper_method :add_to_queue

	def destroy
		@space = Space.find_by!(:sectioncode_id => params[:section_sectioncode], :spacecode => params[:spacecode])
		@space.destroy
	
		redirect_to section_spaces_path, status: :see_other
	end

	private
		def space_params
			params.require(:space).permit(:spacecode, :name, :description)
		end
end
