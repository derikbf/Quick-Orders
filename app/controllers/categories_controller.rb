class CategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :collection, only: %i[ index ]

  # GET /categories or /categories.json
  def index
    if current_user.admin?
      @categories = Category.all
    else
      @categories = Category.kept
    end
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: "A categoria foi criada com sucesso." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    @category.undiscard if params.dig(:restore)

    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_url, notice: "A categoria foi atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    if @category.discarded?
      flash[:alert] = "Categoria deletada previamente!"
    else
      flash[:notice] = "Categoria deletada com sucesso!"
      @category.discard
    end
    redirect_to categories_url
  end

  private
    # Set category list and @search object for the search form
    def collection
      @search = Category.ransack(params[:q])
      @categories = @search.result.order(created_at: :asc)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:title)
    end
end
