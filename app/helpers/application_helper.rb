module ApplicationHelper
  def menu_link_for(group, *categories)
    titled = categories.empty? ? group : categories.last
    link_to titled.ru_title, category_path(group: group, categories: categories.last)
  end

  def categories_menu_view
    @categories_menu_view ||= CategoriesMenuView.new Category.all
  end
end
