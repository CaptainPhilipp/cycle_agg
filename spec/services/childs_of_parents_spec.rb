require 'rails_helper'

RSpec.describe ChildsOfParents do
  include_context 'seed categories'

  let(:indexed_relations) { IndexedCollection.new(ChildrenParent.all) }
  let(:view) { ChildsOfParents.new indexed_categories, indexed_relations }

  describe '#for_parents(one_parent)' do
    let(:indexed_categories) { IndexedCollection.new(Category.sections) }

    it 'shows right sections of group' do
      expect(view.for_parents(group_mtb)).to match_array group_mtb_sections
      expect(view.for_parents(group_road)).to match_array group_road_sections
    end
  end

  describe '#for_parents(*many_parents)' do
    let(:indexed_categories) { IndexedCollection.new(Category.all) }

    it 'shows all subsections of parents' do
      expect(view.for_parents(group_mtb, section_frameset))
        .to match_array subsections_of_mtb_framesets
    end

    it 'shows only right subsections of parents' do
      expect(view.for_parents(group_road, section_frameset))
        .to match_array subsections_of_road_framesets
    end
  end
end
