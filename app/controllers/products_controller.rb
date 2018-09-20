class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  WillPaginate.per_page = 50

  # GET /products
  def index
      @products = Product.all

      #  byebug
      sort_column = params[:sort_column] || :DESC
      sort_value = params[:sort_value] || :id 

      from_price = params[:from_price]
      @products = @products.where('price > ?', from_price) if from_price

      to_price = params[:to_price]
      @products = @products.where('price < ?', to_price) if to_price

      find = params[:find]
      @products = @products.where("name ILIKE '%?%' ", find) if find

      category_id = params[:category_id]
      @products = @products.where(category_id: category_id) if category_id
      #case
      #when
   # if params[:category_id]
    #  @products = Products.where(:category_id => params[:category_id])
   # else
   # @products = Product.order('id DESC')
   # @products = Product.order('name ASC')
   # @products = Product.order('category_id DESC')
   # @products = Product.where(:category_id => 2)
   # @producs = Product.first
  # @products = Product.where(:name => 'Death Be Not Proud', :category_id => 1).order('id DESC')
  
  @products = Product.where(:category_id => category_id).order(sort_value => sort_column)

  paginate json: @products, each_serializer: ProductSerializer#, root: 'data'

  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :price, :category_id, :sort_column, :sort_value,
                                      :from_price, :to_price, :find)
    end
end
