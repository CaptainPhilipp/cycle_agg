require 'rails_helper'

RSpec.describe YandexMl::OffersCategoriesData do
  include_context 'yandex_ml_example'

  let!(:file) { YandexMl::Parser.new(yandex_ml_example_path) }
  let(:yml) { file.yml }

  subject { YandexMl::OffersCategoriesData.call(yml) }

  describe '#call' do
    let(:first_data) { subject.first }

    it 'creates an Array of Hash' do
      expect(subject).to be_a Array
      expect(subject.all? { |elem| elem.is_a?(Hash) }).to be true
    end

    it 'created hash has right data' do
      expect(first_data[:title]).to eq yandex_ml_offer.name
      expect(first_data[:body]).to  eq yandex_ml_offer.description
      expect(first_data[:category_tree_names]).to match_array yandex_ml_categories[0, 3]
    end
  end
end
