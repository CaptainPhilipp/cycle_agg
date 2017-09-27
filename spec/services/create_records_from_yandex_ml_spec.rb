require 'rails_helper'
require "#{Rails.root}/app/services/create_records_from_yandex_ml"

RSpec.describe CreateRecordsFromYandexMl do
  include_context 'yandex_ml_example_path'

  describe '#data' do
    it 'creates an Array of Hash' do
      service = CreateRecordsFromYandexMl.new(yandex_ml_example_path)
      expect(service.data).to be_a Array
      expect(service.data.all? { |elem| elem.is_a?(Hash) }).to be true
    end
  end

  describe '#call' do
    it 'send method to create Publication with parsed data' do
      service = CreateRecordsFromYandexMl.new(yandex_ml_example_path)
      expect(Publication).to receive(:create).with(service.data)
      service.call
    end
  end
end
