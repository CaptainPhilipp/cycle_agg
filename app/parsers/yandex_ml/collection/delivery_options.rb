# frozen_string_literal: true

module YandexML
  module Collection
    class Currencies < Base
      alias currencies list
      alias shop parent_object

      private

      def elements_type
        'option'
      end

      def elements_wrapper
        YandexML::DeliveryOption
      end
    end
  end
end
