require 'rails_helper'

describe 'BuildVocabulary' do
  include_context 'seed synonyms'

  let(:collection) { Category.subsections.to_a + Parameter.all.to_a + ListValue.all.to_a }
  let(:titles) do
    (collection.map(&:ru_title) + collection.map(&:en_title) + Synonym.pluck(:value).to_a).uniq
  end

  describe '.call' do
    it do
      expect(BuildVocabulary.call.keys).to match_array titles
    end
  end
end
