# frozen_string_literal: true

module YandexML
  class Shop < Element
    str_parameters 'name',
                   'company',
                   'url'
    int_parameters 'local_delivery_cost'

    def currencies
      @categories ||= YandexML::Currencies.new(childrens_by_name('currencies'), self)
    end

    def categories
      @categories ||= YandexML::Categories.new(childrens_by_name('categories'), self)
    end

    def offers
      @offers ||= YandexML::Offers.new(childrens_by_name('offers'), self)
    end

    alias catalog parent_object
  end
end
