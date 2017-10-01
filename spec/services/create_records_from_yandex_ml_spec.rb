require 'rails_helper'
require "#{Rails.root}/app/services/hash_from_yandex_ml"

RSpec.describe HashFromYMLService do
  include_context 'yandex_ml_example'

  describe '#call' do
    let(:data) { HashFromYMLService.call(yandex_ml_example_path) }
    let(:first_data) { data.first }

    it 'creates an Array of Hash' do
      expect(data).to be_a Array
      expect(data.all? { |elem| elem.is_a?(Hash) }).to be true
    end

    it 'created hash has right data' do
      expect(first_data[:shop_title]).to eq yandex_ml_shop.name
      expect(first_data[:company]).to    eq yandex_ml_shop.company
      expect(first_data[:shop_url]).to   eq yandex_ml_shop.url

      expect(first_data[:title]).to       eq yandex_ml_offer.name
      expect(first_data[:offer_id]).to    eq yandex_ml_offer.id
      expect(first_data[:url]).to         eq yandex_ml_offer.url
      expect(first_data[:picture]).to     eq yandex_ml_offer.picture
      expect(first_data[:description]).to eq yandex_ml_offer.description
      expect(first_data[:available]).to   eq yandex_ml_offer.available
    end
  end
end
