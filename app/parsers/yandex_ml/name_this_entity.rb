# frozen_string_literal: true

module YandexMl
  # TODO
  class NameThisEntity
    def initialize(string_parser)
      @builder = ParsedEntityBuilder.new(string_parser)
    end

    def call(categories, offers)
      @raw_offers     = offers
      @raw_categories = categories

      add_offers_to_categories

      # indexed_categories.each_value do |category|
      #   category.all_mentioned_categories
      # end
    end

    def close_file
      @file.close
    end

    private

    attr_reader :builder, :file, :yml

    def add_offers_to_categories
      raw_offers.each do |raw_offer|
        offer    = builder.build_offer(raw_offer)
        category = indexed_categories[offer.category_id]

        builder.add_offer_to_category offer, category
      end
    end

    def indexed_categories
      @indexed_categories ||= {}.tap do |hash|
        raw_categories.each do |raw_category|
          category = builder.build_category(raw_category)
          hash[category.id] = category
        end

        hash.each_value { |category| category.parent = hash[category.parent_id] }
      end
    end
  end
end
