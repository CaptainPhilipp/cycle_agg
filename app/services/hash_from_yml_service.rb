# parse data from Yandex markup language file, and creates Publication for it
class HashFromYMLService
  def call(yml_file_adress)
    @yml_file_adress = yml_file_adress
    parse_yandex_ml_file
  end

  def self.call(yml_file_adress)
    new.call(yml_file_adress)
  end

  private

  def parse_yandex_ml_file
    @file = open @yml_file_adress
    yml   = YandexML::File.new(@file)

    merge_multiple_hashes(yml.shop, yml.offers).to_a
  ensure
    @file.close
  end

  def merge_multiple_hashes(shop, offers)
    shop_data = extract_shop_data(shop)

    offers.map do |offer|
      extract_offer_data(offer).merge(shop_data)
    end
  end

  def extract_shop_data(shop)
    {
      shop_title: shop.name,
      company: shop.company,
      shop_url: shop.url
    }
  end

  def extract_offer_data(offer)
    {
      title: offer.name,
      offer_id: offer.id,
      url: offer.url,
      picture: offer.picture,
      description: offer.description,
      available: offer.available
    }
  end
end
