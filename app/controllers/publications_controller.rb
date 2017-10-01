class PublicationsController < ApplicationController
  def index
    @publications = Publication.all

    @parameters = Parameter.where_parents(parents_ids)
  end

  def show
    @publication = Publication.find(params[:id])
  end

  private

  def parents_ids
    @parents_ids ||= { SportGroup: params[:group], Category: categories_ids }
  end

  def categories_ids
    CategoryAdressSerializer.new(params[:categories]).values
  end
end
