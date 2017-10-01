require 'rails_helper'

RSpec.describe Category, type: :model do
  include_context 'seed categories'
  include_context 'HasManyChildsPolymorphic'
  include_context 'HasShortTitle'

  it 'should have_many children_associations' do
    should have_many(:parent_associations)
      .class_name('ChildrenParent')
      .dependent(:destroy)
  end

  context 'scope' do
    it 'sections' do
      expect(Category.sections.all? { |c| c.depth == 1 }).to be true
    end

    it 'subsections' do
      expect(Category.subsections.all? { |c| c.depth == 2 }).to be true
    end
  end
end
