RSpec.shared_context 'for vocabulary' do
  include_context 'seed synonyms'

  it { should have_many(:synonyms) }

  describe '.for_vocabulary scope' do
    it 'have scope' do
      expect(subject.class).to respond_to :for_vocabulary
    end
  end

  describe '.all_words' do
    before do
      subject.en_title = 'en'
      subject.ru_title = 'ру'
      subject.values_type = 'ListValue' if subject.respond_to? :values_type
      subject.save
      subject.synonyms.create(value: 'синоним')
    end

    it 'returns list of synonyms and titles' do
      expect(subject.reload.all_words).to match_array %w[en ру синоним]
    end
  end

  describe '.type' do
    it { expect(subject.type).to eq subject.class.to_s }
  end
end
