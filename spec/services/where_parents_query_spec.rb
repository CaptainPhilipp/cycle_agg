# frozen_string_literal: true

require 'rails_helper'

def add_parents_to(children, *parents)
  tuples = parents.map { |parent| { children: children, parent: parent } }
  ChildrenParent.create tuples
end

describe 'HasManyParents concern' do
  let(:where_parents) { WhereParentsQuery.new(Category) }

  let(:parent1) { Category.create en_title: 'Parent 1' }
  let(:parent2) { Category.create en_title: 'Parent 2' }
  let(:parent3) { Category.create en_title: 'Parent 3' }
  let(:alien_parent) { SportGroup.create en_title: 'AlienParent' }

  let(:children1) { Category.create en_title: 'Children 1' }
  let(:children2) { Category.create en_title: 'Children 2' }
  let(:children3) { Category.create en_title: 'Children 3' }

  describe '.call' do
    before do
      add_parents_to children1, parent1, parent2, parent3
      add_parents_to children2, parent1, parent2
      add_parents_to children3, parent1, alien_parent
    end

    context 'with array of records' do
      fit 'children have chosen parents' do
        expect(where_parents.call(Category: [parent1.id]))
          .to match_array [children1, children2, children3]

        expect(where_parents.call(Category: [parent1.id, parent2.id]))
          .to match_array [children1, children2]

        expect(where_parents.call(Category: [parent1.id, parent2.id, parent3.id]))
          .to match_array [children1]
      end

      it 'children have chosen parents when parent has many classes' do
        expect(where_parents.call(Category: [parent1.id], SportGroup: [alien_parent.id]))
          .to match_array [children3]
      end
    end

    context 'with hash' do
      it 'children have chosen parents' do
        expect(where_parents.call([parent1])).to match_array [children1, children2, children3]

        expect(where_parents.call([parent1, parent2])).to match_array [children1, children2]

        expect(where_parents.call([parent1, parent2, parent3])).to match_array [children1]
      end

      it 'children have chosen parents when parent has many classes' do
        expect(where_parents.call([parent1, alien_parent])).to match_array [children3]
      end
    end
  end
end
