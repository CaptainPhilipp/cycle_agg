# frozen_string_literal: true

module YandexMl
  # wrappers for YML parser library output element builder
  # required for incapsulate vocabulary using
  class ParsedEntityBuilder
    def initialize(string_parser = nil)
      @string_parser = string_parser
    end

    def build_category(category)
      ParsedCategory.new category, mentioned_categories(category.name)
    end

    def build_offer(offer)
      ParsedOffer.new offer, mentioned_categories(offer.name)
    end

    def add_offer_to_category(offer, category)
      category.offers << category
      offer.category = category
    end

    private

    attr_reader :vocabulary

    def mentioned_categories(title)
      string_parser.call(title)
    end
  end
end
