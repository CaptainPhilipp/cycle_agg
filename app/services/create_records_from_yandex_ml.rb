# parse data from Yandex markup language file, and creates Publication for it
class CreateRecordsFromYandexMl
  def initialize(yml_file_adress)
    parse(yml_file_adress)
  end

  def call
    @result ||= model.create(data)
  end

  def data
    @extracted_data ||= @data.to_a # execute lazy
  ensure
    @data = nil
    @file.close
  end

  private

  def parse(yml_file_adress)
    @file = open yml_file_adress
    yml   = YandexML::File.new(@file)

    shop_data = extract_shop_data(yml.shop)
    @data = build_data(yml.offers, shop_data)
  end

  def build_data(offers, shop_data)
    offers.map do |offer|
      extract_offer_data(offer).merge(shop_data)
    end
  end

  def extract_shop_data(shop)
    {
      company: shop.company,
      shop_title: shop.name,
      shop_url: shop.url
    }
  end

  def extract_offer_data(offer)
    {
      offer_id: offer.id,
      url: offer.url,
      title: offer.name,
      picture: offer.picture,
      available: offer.available
    }
  end

  def model
    Publication
  end
end
