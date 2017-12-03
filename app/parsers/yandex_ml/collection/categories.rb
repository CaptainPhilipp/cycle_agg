# frozen_string_literal: true

module YandexML
  class Collection
    class Categories < Indexed
      alias categories list
      alias shop parent_object

      private

      def elements_type
        'category'
      end

      def elements_wrapper
        YandexML::Category
      end
    end
  end
end
