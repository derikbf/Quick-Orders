class ProductsController < ApplicationController
  load_and_authorize_resource
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :collection, only: %i[ index ]


  def index
    def index
      if current_user.admin?
        @products = Product.all
      else
        @products = Product.kept
      end
    end
  end


  def show
  end


  def new
    @product = Product.new
  end


  def edit
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "O produto foi criado com sucesso." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product.undiscard if params.dig(:restore)

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "O produto foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    if @product.discarded?
      flash[:alert] = "Produto deletado previamente!"
    else
      flash[:notice] = "Produto deletado com sucesso!"
      @product.discard
    end

    redirect_to products_url
  end

  private
  # Set Product list and @search object for the search form
  def collection
    @search = Product.ransack(params[:q])
    @products = @search.result.order(created_at: :asc)
  end

  def set_product
      @product = Product.find(params[:id])
    end


    def product_params
      params.require(:product).permit(:name, :description, :price, :category_id)
    end
end
