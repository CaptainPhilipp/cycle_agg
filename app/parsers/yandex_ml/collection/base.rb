# frozen_string_literal: true

module YandexML
  module Collection
    class Base < YandexML::Element
      def by_id(id)
        indexed[id]
      end

      alias [] by_id

      def indexed
        @indexed ||= {}.tap do |hash|
          list.each { |element| hash[element.id] = element }
        end
      end

      def each(&block)
        list.each(&block)
      end

      alias to_h indexed

      def list
        @list ||= childrens_by_name(elements_type).map do |children|
          element_wrapper.new(children, self)
        end
      end

      alias to_a list

      private

      def elements_type
        raise NotImplementedError
      end

      def elements_wrapper
        raise NotImplementedError
      end
    end
  end
end
