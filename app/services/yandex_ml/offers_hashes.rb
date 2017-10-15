# frozen_string_literal: true

module YandexMl
  # Parses data from Yandex markup language, and bultds changeset hashes for
  # creating Publiations
  class OffersHashes
    def initialize(yml)
      @yml = yml
    end

    def call
      offers.map { |offer| offer_data(offer).merge(shop_data) }.force
    end

    def self.call(*args)
      new(*args).call
    end

    private

    attr_reader :yml

    def offer_data(offer)
      { title:       offer.name,
        offer_id:    offer.id,
        url:         offer.url,
        picture:     offer.picture,
        description: offer.description,
        available:   offer.available }
    end

    def shop_data
      @shop_data ||= {
        shop_title: shop.name,
        company:    shop.company,
        shop_url:   shop.url
      }
    end

    def offers
      yml.offers
    end

    def shop
      yml.shop
    end
  end
end
