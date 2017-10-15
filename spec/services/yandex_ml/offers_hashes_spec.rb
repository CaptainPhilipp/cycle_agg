require 'rails_helper'
require "#{Rails.root}/app/services/yandex_ml/offers_hashes"

RSpec.describe YandexMl::OffersHashes do
  include_context 'yandex_ml_example'

  let!(:file) { YandexMl::Parser.new(yandex_ml_example_path) }
  let(:yml) { file.yml }

  subject { YandexMl::OffersHashes.call(yml) }

  after { file.close }

  describe '#call' do
    let(:first_data) { subject.first }

    it 'creates an Array of Hash' do
      expect(subject).to be_a Array
      expect(subject.all? { |elem| elem.is_a?(Hash) }).to be true
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
