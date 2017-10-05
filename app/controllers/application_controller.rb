# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include ApplicationHelper

  before_action :load_sport_groups
  before_action :load_categories
  before_action :load_relations

  private

  def load_sport_groups
    @indexed_sport_groups = IndexedCollection.new(SportGroup.all)
  end

  def load_categories
    categories ||= Category.all
    grouped_categories   = categories.group_by(&:depth)

    @indexed_categories  = IndexedCollection.new(categories)
    @indexed_sections    = IndexedCollection.new(grouped_categories[1])
  end

  def load_relations
    relations =
      ChildrenParent.where parent_type: %w[SportGroup Category], children_type: 'Category'

    @indexed_relations = IndexedCollection.new(relations)
  end
end
