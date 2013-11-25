class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json

# GET /orders/1/items
	def index
		@orders = Order.all
		# For URL like /orders/1/items
		# Get the order with id=1
		@order = Order.find(params[:order_id])

		# Access all items for that order
		@items = @order.items
	end
	
		# GET /orders/1/items/2
	
	def show
		@order = Order.find(params[:order_id])
		# For URL like /orders/1/items/2
		# Find an item in orders 1 that has id=2
		@item = @order.items.find(params[:id])
	end
	
		# GET /orders/1/items/new
	def new
		@order = Order.find(params[:order_id])
		
		# Associate an item object with order 1
		@item = @order.items.build
	end
	
		# POST /orders/1/items
	def create
		@order = Order.find(params[:order_id])
		
		# For URL like /orders/1/items
		# Populate an item associate with order 1 with form data
		# Order will be associated with the item
		@item = @order.items.build(params[:item])
	if @item.save
		# Save the item successfully
		redirect_to order_item_url(@order, @item)
	else
		render :action =>"new"
	end
	

		# GET /orders/1/items/2/edit
	def edit
		@order = Order.find(params[:order_id])
		
		# For URL like /orders/1/items/2/edit
		# Get item id=2for order 1
		@item = @order.items.find(params[:id])
	end
	
		# PUT /orders/1/items/2
	def update
		@order = Order.find(params[:order_id])
		@item = Item.find(params[:id])
		if @item.update_attributes(params[:item])
			# Save the item successfully
		redirect_to order_item_url(@order, @item)
	else
		render :action => "edit"
	end
end

		# DELETE /orders/1/items/2
	def destroy
		@order = Order.find(params[:order_id])
		@item = Item.find(params[:id])
		@item.destroy
		
		respond_to do |format|
			format.html { redirect_to order_items_path(@order) }
			format.xml { head :ok }
	end
end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order_name)
    end
end


  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order_date, :user_id)
    end
end
