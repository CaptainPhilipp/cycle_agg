require 'rails_helper'

RSpec.describe Pricelist, type: :model do
  let(:filepath) { "#{Rails.root}/spec/upload_fixtures/yandex_ml_example.xml" }
  let(:parser)   { YandexMl::Parser.new(filepath) }
  let(:expected_hashes) { YandexMl::OffersHashes.call(parser.yml) }

  after { parser.close }

  describe '.after_create hook' do
    it 'initializes Publications creation' do
      pricelist = Pricelist.new
      pricelist.attachment = File.new(filepath)

      expect(Publication).to receive(:create).with(expected_hashes)

      Sidekiq::Testing.inline! do
        pricelist.save
      end
    end
  end
end
