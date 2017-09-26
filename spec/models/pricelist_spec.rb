require 'rails_helper'

RSpec.describe Pricelist, type: :model do
  let(:filepath) { "#{Rails.root}/spec/upload_fixtures/yandex_ml_example.xml" }

  describe '.after_create hook' do
    it 'initializes Publications creation' do
      pricelist = Pricelist.new
      pricelist.attachment = File.new(filepath)

      expect(Publication).to receive(:create)
      pricelist.save
    end
  end
end
