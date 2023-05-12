class ItemsController < ApplicationController
	before_action :authenticate_user!
	def index
		@section = Section.find_by!(:sectioncode => params[:section_sectioncode])
		@space = Space.find_by!(:spacecode => params[:space_spacecode])
		@items = @space.items
	end
	def show
		@section = Section.find_by!(:sectioncode => params[:section_sectioncode])
		@space = Space.find_by!(:sectioncode_id => params[:section_sectioncode], :spacecode => params[:space_spacecode])
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


	def add_large_to_queue
		@item = Item.find_by!(:sectioncode_id => params[:section_sectioncode], :spacecode_actual_id => Space.find_by!(:spacecode=>params[:space_spacecode], :sectioncode_id => params[:section_sectioncode]).spacecode, :itemcode => params[:item_itemcode])

		# TODO USE HASHES!

		if @current_queue.print_queue_items.find_by(:name => "Large Item Label for #{@item.name}") != nil
			printItem = @current_queue.print_queue_items.find_by(:name => "Large Item Label for #{@item.name}")
			printItem.quantity += 1
			printItem.print_content = render("_label", locals: { item: @item }, :layout => false)
			printItem.save!
		else
			printItem = @current_queue.print_queue_items.new(:name => "Large Item Label for #{@item.name}", :quantity => 1, :print_content => render("_label", locals: { item: @item }, :layout => false))
			printItem.save!
		end

		respond_to do |format|
			# Handle a Successful Unfollow
			format.html
			format.js
		end
	end
	helper_method :add_large_to_queue

	def add_small_to_queue
		puts params
		@item = Item.find_by!(:sectioncode_id => params[:section_sectioncode], :spacecode_actual_id => Space.find_by!(:spacecode=>params[:space_spacecode], :sectioncode_id => params[:section_sectioncode]).spacecode, :itemcode => params[:item_itemcode])
		
		# TODO USE HASHES!

		if @current_queue.print_queue_items.find_by(:name => "Small Item Label for #{@item.name}") != nil
			printItem = @current_queue.print_queue_items.find_by(:name => "Small Item Label for #{@item.name}")
			printItem.quantity += 1
			printItem.print_content = render("_labelsmall", locals: { item: @item }, :layout => false)
			printItem.save!
		else
			printItem = @current_queue.print_queue_items.new(:name => "Small Item Label for #{@item.name}", :quantity => 1, :print_content => render("_labelsmall", locals: { item: @item }, :layout => false))
			printItem.save!
		end


		respond_to do |format|
			# Handle a Successful Unfollow
			format.html
			format.js
		end
	end
	helper_method :add_small_to_queue

	
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
