# frozen_string_literal: true

module YandexMl
  # Parses data from Yandex markup language file,
  # and prepares text data for analizis
  class OffersCategoriesData
    def initialize(yml)
      @yml = yml
    end

    def call
      offers.map { |offer| offer_data(offer) }.force
    end

    def self.call(*args)
      new(*args).call
    end

    private

    attr_reader :yml

    def offer_data(offer)
      {
        id:       offer.id,
        title:    offer.name,
        body:     offer.description,
        category_tree_names: parent_categories(offer.category_id.value)
      }
    end

    def parent_categories(id, titles = [])
      category = indexed_categories[id]
      titles << category.name
      parent_id = category.parent_id
      parent_id ? parent_categories(parent_id, titles) : titles
    end

    def indexed_categories
      @category_names_by_id ||= {}.tap do |collection|
        shop.categories.to_a.each { |category| collection[category.id] = category }
      end
    end

    def offers
      yml.offers
    end

    def shop
      yml.shop
    end
  end
end
