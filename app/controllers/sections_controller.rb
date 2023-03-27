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
	end
	
	def update
		@section = Section.find_by!(:sectioncode => params[:sectioncode])
	
		if @section.update(section_params)
			redirect_to section_path(@section.sectioncode)
		else
			render :new, status: :unprocessable_entity
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
