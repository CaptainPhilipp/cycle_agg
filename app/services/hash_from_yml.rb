# frozen_string_literal: true

# parse data from Yandex markup language file, and creates Publication for it
class HashFromYML
  def call(filepath)
    @file = open(filepath)
    offers
    titles
    self
  ensure
    @file.close
  end

  def offers
    @offers ||= parsed_offers.map { |offer| offer_data(offer).merge(shop_data) }.force
  end

  def titles
    @titles ||= parsed_offers.map { |offer| offer_titles_data(offer) }.force
  end

  def self.call(*args)
    new.call(*args)
  end

  private

  def offer_data(offer)
    { title:       offer.name,
      offer_id:    offer.id,
      url:         offer.url,
      picture:     offer.picture,
      description: offer.description,
      available:   offer.available }
  end

  def offer_titles_data(offer)
    {
      id:       offer.id,
      title:    offer.name,
      body:     offer.description,
      category_tree_names: parent_categories(offer.category_id.value)
    }
  end

  def shop_data
    @shop_data ||= {
      shop_title: parsed_shop.name,
      company:    parsed_shop.company,
      shop_url:   parsed_shop.url
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
      parsed_shop.categories.to_a.each { |category| collection[category.id] = category }
    end
  end

  def parsed_offers
    yml.offers
  end

  def parsed_shop
    yml.shop
  end

  def yml
    @yml ||= YandexML::File.new(@file)
  end
end
