class ItemsController < ApplicationController
	before_action :authenticate_user!
	def index
		@section = Section.find_by!(:sectioncode => params[:section_sectioncode])
		@space = Space.find_by!(:spacecode => params[:space_spacecode])
		@items = @space.items
	end
	def show
		@item = Item.find_by!(:sectioncode_id => params[:section_sectioncode], :spacecode_actual_id => Space.find_by!(:spacecode=>params[:space_spacecode], :sectioncode_id => params[:section_sectioncode]).spacecode, :itemcode=>params[:itemcode])
	end

	def new
		@section = Section.find_by!(:sectioncode => params[:section_sectioncode])
		@space = Space.find_by!(:spacecode=>params[:space_spacecode], :sectioncode_id => params[:section_sectioncode])
		@item = Item.new
	end
	
	def create
		@section = Section.find_by!(:sectioncode => params[:section_sectioncode])
		@space = Space.find_by!(:spacecode=>params[:space_spacecode], :sectioncode_id => params[:section_sectioncode])
		@item = Item.new(item_params)
		@item.spacecode_actual_id = @space.id
		@item.sectioncode_id = @section.sectioncode
		if @item.save
			redirect_to section_space_item_path(@space.sectioncode_id, @space.spacecode, @item.itemcode)
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
		@section = Section.find_by!(:sectioncode => params[:section_sectioncode])
		@space = Space.find_by!(:spacecode=>params[:space_spacecode], :sectioncode_id => params[:section_sectioncode])
		@item = Item.find_by!(:sectioncode_id => params[:section_sectioncode], :spacecode_actual_id => Space.find_by!(:spacecode=>params[:space_spacecode], :sectioncode_id => params[:section_sectioncode]).spacecode, :itemcode=>params[:itemcode])
		@backpath = section_space_item_path(@item.sectioncode_id, @space.spacecode, @item.itemcode)
		@name = @item.name
	end
	
	def update
		@section = Section.find_by!(:sectioncode => params[:section_sectioncode])
		@space = Space.find_by!(:spacecode=>params[:space_spacecode], :sectioncode_id => params[:section_sectioncode])
		@item = Item.find_by!(:sectioncode_id => params[:section_sectioncode], :spacecode_actual_id => Space.find_by!(:spacecode=>params[:space_spacecode], :sectioncode_id => params[:section_sectioncode]).spacecode, :itemcode=>params[:itemcode])
		@backpath = section_space_item_path(@item.sectioncode_id, @space.spacecode, @item.itemcode)
		@name = @item.name
		
		if @item.update(item_params)
			redirect_to section_space_item_path(@space.sectioncode_id, @space.spacecode, @item.itemcode)
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@item = Item.find_by!(:sectioncode_id => params[:section_sectioncode], :spacecode_actual_id => Space.find_by!(:spacecode=>params[:space_spacecode], :sectioncode_id => params[:section_sectioncode]).spacecode, :itemcode=>params[:itemcode])
		@item.destroy
	
		redirect_to section_space_items_path, status: :see_other
	end

	private
		def item_params
			params.require(:item).permit(:itemcode, :name, :description, :quantity)
		end

end
