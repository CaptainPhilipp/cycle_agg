require 'rails_helper'
require "#{Rails.root}/app/services/category_adress_serializer"

describe CategoryAdressSerializer do
  include_context 'seed categories'

  let(:service) { CategoryAdressSerializer }

  let(:serialized_ids) { service.to_ids(*mtb_frameset_rockrings) }
  let(:serialized_short_titles) { service.to_short_titles(*mtb_frameset_rockrings) }

  context 'singleton method' do
    describe '.to_ids' do
      it 'returns right serialized string' do
        expect(serialized_ids).to eq mtb_frameset_rockrings.map(&:id) * ':'
      end
    end

    describe '.to_short_titles' do
      it 'returns right serialized string' do
        expect(serialized_short_titles).to eq mtb_frameset_rockrings.map(&:short_title) * ':'
      end
    end
  end

  context 'instance method' do
    let(:service_obj) { service.new(serialized) }

    describe '#values' do
      context 'when serialized ids' do
        let(:serialized) { serialized_ids }

        it 'retusns right serialized valued' do
          expect(service_obj.values).to match_array mtb_frameset_rockrings.map(&:id)
        end
      end

      context 'when serialized short_titles' do
        let(:serialized) { serialized_short_titles }

        it 'retusns right serialized valued' do
          expect(service_obj.values).to match_array mtb_frameset_rockrings.map(&:short_title)
        end
      end
    end

    describe '#type' do
      context 'when serialized ids' do
        let(:serialized) { serialized_ids }

        it 'returns type of serialized values' do
          expect(service_obj.type).to eq :id
        end
      end

      context 'when serialized short_titles' do
        let(:serialized) { serialized_short_titles }

        it 'returns type of serialized values' do
          expect(service_obj.type).to eq :short_title
        end
      end
    end
  end
end
