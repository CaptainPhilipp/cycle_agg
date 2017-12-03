# frozen_string_literal: true

module YandexML
  class Category < Element
    str_attributes 'id', 'parentId'

    def text
      node_text_content(node)
    end

    def parent_category
      categories_collection[parent_id]
    end

    alias categories_collection parent_object
  end
end
