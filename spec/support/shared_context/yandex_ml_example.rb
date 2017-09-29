RSpec.shared_context 'yandex_ml_example' do
  let(:yandex_ml_example_path) { "#{Rails.root}/spec/upload_fixtures/yandex_ml_example.xml" }
  let(:yandex_ml_example_file) { YandexML::File.new(open(yandex_ml_example_path)) }
  let(:yandex_ml_shop)         { yandex_ml_example_file.shop }
  let(:yandex_ml_shop_title)   { yandex_ml_shop.name }
  let(:yandex_ml_offer)        { yandex_ml_example_file.offers.first }
end
