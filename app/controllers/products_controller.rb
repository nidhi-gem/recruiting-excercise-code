class ProductsController < ApplicationController
  before_action :all_products, except: [:show]

  def index
    session[:values] = nil
  end

  def show
    @product = Product.find(params[:id])
  end

  def exchange_price
    @values = Exchangeable.new(params).retrieve_exchange_rate
    if @values.present?
      session[:values] = @values
    else
      @values = 'API response is not available'
    end
    respond_to do |format|
      format.js
      format.html { @values }
    end
  end

  private

  def all_products
    @products = Product.all
  end

  def product_params
    params.require(:product).permit(:name, :description, :price_in_cents)
  end
end
