# frozen_string_literal: true

module YandexML
  class Catalog < Collection
    def flat_each_offer
      shops.each do |shop|
        shop.offers.list.each { |offer| yield offer }
      end
    end

    def shop
      raise 'Count of shops is not equals 1' unless shops.size == 1
      shops.first
    end

    alias shops list

    private

    def elements_type
      'shop'
    end

    def elements_wrapper
      YandexML::Shop
    end
  end
end
