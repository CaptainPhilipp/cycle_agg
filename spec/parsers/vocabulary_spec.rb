require 'rails_helper'

describe 'Vocabulary' do
  include_context 'seed synonyms'

  let(:vocabulary) { Vocabulary.new }

  let(:collection) { Category.all.to_a + Parameter.all.to_a + ListValue.all.to_a }
  let(:titles) do
    (collection.map(&:ru_title) + collection.map(&:en_title) + Synonym.pluck(:value).to_a).uniq
  end

  let(:filled_vocabulary) { vocabulary.fill(collection) }

  describe '#fill' do
    it 'fills' do
      expect(filled_vocabulary.keys).to match_array titles
    end
  end

  describe '#[]' do
    it 'takes by word' do
      synonym = subsection_forks.synonyms.last.value
      expect(filled_vocabulary[synonym]).to match_array subsection_forks
    end
  end

  describe '#add' do
    it 'fills by one' do
      collection.each { |record| vocabulary.add record }
      expect(vocabulary.keys).to match_array titles
    end
  end
end
