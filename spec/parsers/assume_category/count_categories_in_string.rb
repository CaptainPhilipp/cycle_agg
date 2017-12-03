require 'rails_helper'

describe CountCategoriesInString do
  include_context 'seed synonyms'

  let(:string_with_category) { 'вилка Rockshox Sector 34' }
  let(:string_with_term) { 'Rockshox Sector 34 воздух' }

  let(:category) { Category.find_by(en_title: 'Forks') }

  let(:subject_with_category) { subject.call(string_with_category) }
  let(:subject_with_term) { subject.call(string_with_term) }

  describe '#call' do
    it 'returns hash with counters' do
      expect(subject.call('string').categories).to  be_a Hash
      expect(subject.call('string').terms).to       be_a Hash
      expect(subject.call('string').total_count).to be_a Integer
    end

    it '#total_count returns right result' do
      expect(subject_with_category.total_count).to eq 1
      expect(subject_with_term.total_count).to eq 1
    end

    describe '#categories' do
      it 'counts category' do
        expect(subject_with_category.categories[category]).to eq 1
      end

      it 'not counts other term' do
        expect(subject_with_term.categories[category]).to eq 0
      end
    end

    describe '#terms' do
      it 'counts term' do
        expect(subject_with_term.terms[category]).to eq 1
      end

      it 'not counts category' do
        expect(subject_with_category.terms[category]).to eq 0
      end
    end
  end
end
