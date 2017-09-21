class PricelistsController < ApplicationController
  def new
    @pricelist = Pricelist.new
  end

  def create; end
end
