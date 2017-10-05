# frozen_string_literal: true

class PublicationsController < ApplicationController
  def index
    @publications = Publication.all
    @parameters = Parameter.where_parents current_sport_group, current_category
  end

  def show
    @publication = Publication.find(params[:id])
  end

  private

  def current_sport_group
    @current_sport_group ||= @indexed_sport_groups.by_key(short_title: params[:sport_group])
  end

  def current_category
    @current_category ||= @indexed_categories.by_key(short_title: params[:category])
  end

  def load_relations
    @indexed_relations =
      IndexedCollection.new(
        ChildrenParent.where(parent_type: %w[SportGroup Category],
                             children_type: %w[Category Value])
      )
  end
end
