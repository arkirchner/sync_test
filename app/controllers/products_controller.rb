class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, only: [:index]
  respond_to :js, only: [:new, :create, :update, :destroy, :history]



  def index
    @products = Product.all
  end




  def new
    @product = Product.new
  end



  def create
    if @product  = Product.create(product_params)
      sync_new @product
      respond_with(@product)
    #else
      #respond_with(@product)
    end
  end

  def update
    if @product.update_attributes(product_params)
      # flash[:success] = "Post was updated! #{make_undo_link}"
      sync_update @product
      respond_with(@product)
    else
      respond_with(@product)
    end
  end

  def destroy
    @product.destroy
    sync_destroy @product
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:products)
    end
end
