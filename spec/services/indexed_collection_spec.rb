require 'rails_helper'

RSpec.describe 'IndexedCollection' do
  include_context 'seed categories'

  let(:indexed_categories) { IndexedCollection.new(Category.all) }

  describe '#by_key' do
    let(:by_key) { indexed_categories.by_key(key) }

    context 'with one value' do
      let(:key) { { en_title: 'Frameset' } }

      it 'returns record having required key value' do
        expect(by_key).to match_array [section_frameset]
      end
    end

    context 'with more than one value' do
      let(:key) { { en_title: %w[Frameset Forks] } }

      it 'returns records having required key values' do
        expect(by_key).to match_array [section_frameset, subsection_forks]
      end
    end
  end

  describe '#by_keys' do
    let(:by_keys) { indexed_categories.by_keys(keys) }

    context 'with one key' do
      let(:keys) { { en_title: 'Frameset' } }

      it 'returns records, having concrete values' do
        expect(by_keys).to match_array section_frameset
      end
    end

    context 'with many keys' do
      let(:keys) { { en_title: 'Frameset', depth: 1 } }

      it 'returns records, having concrete values' do
        expect(by_keys).to match_array section_frameset
      end
    end

    context 'with wrong values' do
      let(:keys) { { en_title: 'Frameset', depth: 7 } }

      it 'returns empty array, whan cant find record with concrete values' do
        expect(by_keys).to eq []
      end
    end
  end
end
