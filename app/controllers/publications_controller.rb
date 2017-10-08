# frozen_string_literal: true

class PublicationsController < ApplicationController
  include PublicationsHelper

  before_action :load_parameters

  def index
    @publications = Publication.all
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

  def load_parameters
    @parameters = Parameter.where_parents(parent_ids_by_class)
    @indexed_list_values = IndexedCollection.new ListValue.where_parents(parent_ids_by_class)
  end

  # hook for private ApplicationController#load_relations
  def relations_types
    { parent_type: %w[SportGroup Category Parameter], children_type: %w[Category ListValue] }
  end
end
