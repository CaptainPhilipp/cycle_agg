# frozen_string_literal: true

module YandexMl
  # wrapper for YML parser library output element
  class ParsedOffer < Deleagtor
    attr_reader :mentioned_categories, :offer
    attr_accessor :category

    def __getobj__
      @offer
    end

    def initialize(offer, mentioned_categories)
      @mentioned_categories = mentioned_categories
      @offer = offer
    end

    def category_id
      offer.category_id.value
    end
  end
end
