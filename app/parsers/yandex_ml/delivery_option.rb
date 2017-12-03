# frozen_string_literal: true

module YandexML
  class DeliveryOption < Element
    int_attributes 'cost', 'days', 'order-before'

    def offer
      delivery_options_collection.offer
    end

    alias delivery_options_collection parent_object
  end
end
