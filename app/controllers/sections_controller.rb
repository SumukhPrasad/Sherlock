class SectionsController < ApplicationController
	before_action :authenticate_user!
	def index
		@sections = Section.all.sort_by(&:sectioncode)
	end
	def show
		@section = Section.find_by!(:sectioncode => params[:sectioncode])
	end

	def new
		@section = Section.new
	end
	
	def create
		@section = Section.new(section_params)

		if @section.save
			redirect_to section_path(@section.sectioncode)
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
		@section = Section.find_by!(:sectioncode => params[:sectioncode])
		@backpath = section_path(@section.sectioncode)
		@name = @section.name
	end

	def add_to_queue
		# @current_queue
		@section = Section.find_by!(:sectioncode => params[:sectioncode])

		# TODO USE HASHES!

		if @current_queue.print_queue_items.find_by(:name => "Section Label for #{@section.name}") != nil
			printItem = @current_queue.print_queue_items.find_by(:name => "Section Label for #{@section.name}")
			printItem.quantity += 1
			printItem.print_content = render("_label", locals: { section: @section }, :layout => false)
			printItem.save!
		else
			printItem = @current_queue.print_queue_items.new(:name => "Section Label for #{@section.name}", :quantity => 1, :print_content => render("_label", locals: { section: @section }, :layout => false))
			printItem.save!
		end

		

		respond_to do |format|
			# Handle a Successful Unfollow
			format.html
			format.js
		end
	end

	helper_method :add_to_queue
	
	def update
		@section = Section.find_by!(:sectioncode => params[:sectioncode])
		@backpath = section_path(@section.sectioncode)
		@name = @section.name
		if @section.update(section_params)
			redirect_to section_path(@section.sectioncode)
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@section = Section.find_by!(:sectioncode => params[:sectioncode])
		@section.destroy
	
		redirect_to sections_path, status: :see_other
	end

	private
		def section_params
			params.require(:section).permit(:sectioncode, :name, :description)
		end
end
