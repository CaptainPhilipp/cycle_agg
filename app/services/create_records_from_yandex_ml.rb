# parse data from Yandex markup language file, and creates Publication for it
class CreateRecordsFromYandexMl
  def initialize(yml_file_adress)
    @yml_file_adress = yml_file_adress
  end

  def call
    @result ||= model.create(data)
  end

  def data
    @data ||= parse_yandex_ml_file
  end

  private

  def parse_yandex_ml_file
    @file = open @yml_file_adress
    yml   = YandexML::File.new(@file)

    shop_data = extract_shop_data(yml.shop)

    merge_multiple_hashes(shop_data, yml.offers).to_a
  ensure
    @file.close
  end

  def merge_multiple_hashes(shop_data, offers)
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
      description: offer.description,
      available: offer.available
    }
  end

  def model
    Publication
  end
end
