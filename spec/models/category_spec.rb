require 'rails_helper'

RSpec.describe Category, type: :model do
  include_context 'seed categories'
  include_context 'has localizeable title'
  include_context 'HasManyParentsPolymorphic'
  include_context 'HasShortTitle'
  include_context 'for vocabulary'

  context 'scope' do
    it 'sections' do
      expect(Category.sections.all? { |c| c.depth == 1 }).to be true
    end

    it 'subsections' do
      expect(Category.subsections.all? { |c| c.depth == 2 }).to be true
    end
  end
end
