module ApplicationHelper
  def menu_link_for(*categories)
    link_to categories.last.ru_title, ''
  end

  def categories_menu_view
    CategoriesMenuView.new Category.all, groups: SportGroup.all
  end
end
