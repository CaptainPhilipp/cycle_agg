class PricelistsController < ApplicationController
  def new
    @pricelist = Pricelist.new
  end

  def create
    @pricelist = Pricelist.create(pricelist_params)

    if @pricelist.valid?
      redirect_to @pricelist
    else
      render :new
    end
  end

  def show
    @pricelist = Pricelist.find(params[:id])
  end

  private

  def pricelist_params
    params.require(:pricelist).permit(:attachment)
  end
end
