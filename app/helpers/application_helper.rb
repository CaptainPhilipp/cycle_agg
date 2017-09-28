module ApplicationHelper
  def menu_link_for(category)
    link_to category.ru_title, ''
  end
end
