# frozen_string_literal: true

module YandexML
  module Collection
    class Currencies < Indexed
      alias currencies list
      alias shop parent_object

      private

      def elements_type
        'currency'
      end

      def elements_wrapper
        YandexML::Currency
      end
    end
  end
end
