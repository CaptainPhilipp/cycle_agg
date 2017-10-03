class PublicationsController < ApplicationController
  def index
    @publications = Publication.all

    @parameters = parent_ids.empty? ? Parameter.all : Parameter.where_parents(parent_ids)
  end

  def show
    @publication = Publication.find(params[:id])
  end

  private

  def parent_ids
    return @parent_ids if @parent_ids
    @parent_ids = {}
    return @parent_ids unless params[:group] || params[:categories]

    @parent_ids[:SportGroup] = group_id     if params[:group]
    @parent_ids[:Category] = categories_ids if params[:categories]
  end

  def group_id
    [params[:group].to_i]
  end

  def categories_ids
    CategoryAdressSerializer.new(params[:categories]).ids
  end
end
