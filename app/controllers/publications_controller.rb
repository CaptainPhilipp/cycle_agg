# frozen_string_literal: true

class PublicationsController < ApplicationController
  def index
    @publications = Publication.all
    @parameters = Parameter.where_parents(parent_ids_by_class)
  end

  def show
    @publication = Publication.find(params[:id])
  end

  private

  def parent_ids_by_class
    @parent_ids ||= {}.tap do |parent_ids|
      parent_ids[:SportGroup] = [params[:sport_group].to_i] if params[:sport_group]
      parent_ids[:Category]   = [params[:category].to_i]    if params[:category]
    end
  end

  def relations_types
    { parent_type: %w[SportGroup Category Parameter], children_type: %w[Category Value] }
  end
end
