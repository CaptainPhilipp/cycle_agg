# frozen_string_literal: true

module ApplicationHelper
  def menu_link_for(group, *categories)
    category = categories.last
    titled = [group, *categories].last

    link_to titled.ru_title, category_path(group, category)
  end

  def show_sections_for(*parents)
    @sections_view ||= ChildrensView.new(@indexed_sections, @indexed_relations)
    @sections_view.for_parents(*parents)
  end

  def show_subshow_sections_for(*parents)
    @subsections_view ||= ChildrensView.new(@indexed_subsections, @indexed_relations)
    @subsections_view.for_parents(*parents)
  end
end
