RSpec.shared_context 'for vocabulary' do
  describe '.for_vocabulary scope' do
    pending
  end

  describe '.all_words' do
    pending
  end

  describe '.type' do
    it { expect(subject.type).to eq subject.class.to_s }
  end
end
