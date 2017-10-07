# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include ApplicationHelper

  before_action :load_sport_groups
  before_action :load_categories
  before_action :load_relations

  private

  def load_sport_groups
    @sport_groups = SportGroup.all
  end

  def load_categories
    by_depth = Category.all.group_by(&:depth)
    @indexed_sections    = IndexedCollection.new(by_depth[1])
    @indexed_subsections = IndexedCollection.new(by_depth[2])
  end

  def load_relations
    @indexed_relations = IndexedCollection.new ChildrenParent.where(relations_types)
  end

  def relations_types
    { parent_type: %w[SportGroup Category], children_type: 'Category' }
  end
end
