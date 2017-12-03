# frozen_string_literal: true

module YandexML
  class Currency < Element
    str_attributes 'id', 'rate'

    def shop
      currencies_collection.shop
    end

    # TODO: currency can be CBRF, NBU, NBK, CB

    alias currencies_collection parent_object
  end
end
