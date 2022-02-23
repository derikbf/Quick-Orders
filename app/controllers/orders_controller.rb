class OrdersController < ApplicationController
  before_action :set_order, only: %i[ edit update destroy report_status ]
  before_action :collection, only: %i[ index ]

  # GET /orders or /orders.json
  def index
  end

  # GET /orders/1 or /orders/1.json
  def show
    @order = Order.where(id: params[:id]).includes(order_products: [:product]).first
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @order.user = current_user
    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Pedido criado com sucesso." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Pedido atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Pedido excluido com sucesso." }
      format.json { head :no_content }
    end
  end

  # POST /orders/report_status/:id with :status param
  def report_status
    @order.update(status: params[:status])
    redirect_to order_path(@order.id)
  end

  private
    def collection
      default_order = :status
      @search = Order.ransack(params[:q])
      @orders = @search.result.order(default_order)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def collection
      @search = Order.ransack(params[:q])
      @orders = @search.result.order(created_at: :desc)
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:client_name, :table, :user_id, :status, order_products_attributes: [:id, :quantity, :observation, :product_id, :_destroy])
    end
end
