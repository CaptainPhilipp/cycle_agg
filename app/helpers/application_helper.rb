# frozen_string_literal: true

module ApplicationHelper
  def menu_link_for(group, *categories)
    category = categories.last
    titled = [group, *categories].last

    link_to titled.ru_title, category_path(group, category)
  end

  def sport_groups
    @sport_groups
  end

  def sections_menu_view
    @sections_menu_view ||= MenuView.new(@indexed_sections, @indexed_relations)
  end

  def subsections_menu_view
    @subsections_menu_view ||= MenuView.new(@indexed_subsections, @indexed_relations)
  end

  def values_menu_view
    @parameters_menu_view ||= MenuView.new(@indexed_values, @indexed_relations)
  end
end
