class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  
  # GET /products or /products.json
  def index
    @products = Product.all.order("created_at desc")
  end

  # GET /products/1 or /products/1.json
  def show
    # @product is already set by set_product
  end

  # GET /products/new
  def new
    @product = current_user.products.build
  end

  # GET /products/1/edit
  def edit
    # @product is already set by set_product
  end

  # POST /products or /products.json
  def create
    @product = current_user.products.build(product_params)

    if @product.save
      # Handle file upload
      if params[:product][:image].present?
        uploaded_io = params[:product][:image]
        File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
          file.write(uploaded_io.read)
        end
      end
  
      redirect_to @product, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:brand, :model, :description, :condition, :finish, :title, :price, :image)
  end

  # Ensure the current user is the creator of the product
  def authorize_user
    unless current_user == @product.user
      redirect_to products_path, alert: "You are not authorized to perform this action."
    end
  end
end