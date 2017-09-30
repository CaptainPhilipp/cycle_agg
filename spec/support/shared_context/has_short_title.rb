RSpec.shared_context 'HasShortTitle' do
  describe 'before_save change_short_title' do
    let!(:category) { Category.create en_title: 'aaa and bbb ccc' }

    it 'writes short_title after change en_title' do
      expect(category.short_title).to eq 'aaa-n-bbb-ccc'
    end

    it 'changes short_title after change en_title' do
      category.update en_title: 'aaa bbb and ccc', short_title: nil
      expect(category.short_title).to eq 'aaa-bbb-n-ccc'
    end
  end
end
