require 'rails_helper'

RSpec.describe Category, type: :model do
  include_context 'seed categories'

  it 'should have_many parent_associations' do
    should have_many(:parent_associations)
      .class_name('ChildrenParent')
      .dependent(:destroy)
  end

  it 'should have_many children_associations' do
    should have_many(:children_associations)
      .class_name('ChildrenParent')
      .dependent(:destroy)
  end

  it 'should have_many child_sections' do
    should have_many(:child_sections)
      .conditions(depth: 1)
      .through(:children_associations)
  end

  it 'should have_many child_subsections' do
    should have_many(:child_subsections)
      .conditions(depth: 2)
      .through(:children_associations)
  end

  context 'scope' do
    it '#groups' do
      expect(Category.groups.all? { |c| c.depth.zero? }).to be true
    end

    it '#sections' do
      expect(Category.sections.all? { |c| c.depth == 1 }).to be true
    end

    it '#subsections' do
      expect(Category.subsections.all? { |c| c.depth == 2 }).to be true
    end
  end

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
