class ProductsController < ApplicationController
  skip_before_action :protect_pages, only: [:index, :show]
  before_action :set_product, only: %i[show edit update destroy]
  before_action :set_categories, only: %i[new edit]

  def index
=begin
    @products = Product.with_attached_photo
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id].to_i)
    end
    if params[:min_price].present?
      @products = @products.where("price >= ?", params[:min_price])
    end
    if params[:max_price].present?
      @products = @products.where("price <= ?", params[:max_price])
    end
    if params[:query_text].present?
      @products = @products.search_full_text(params[:query_text])
    end

    order_by = Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])

    @products = @products.order(order_by)
=end

    @categories = Category.order(name: :asc).load_async
    @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index), items: 12)
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

    if @product.save
      redirect_to products_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: t('.destroyed'), status: :see_other
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def set_categories
    @categories = Category.category_select
  end

  def product_params_index
    params.permit(:category_id, :min_price, :max_price, :query_text, :order_by)
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end
end