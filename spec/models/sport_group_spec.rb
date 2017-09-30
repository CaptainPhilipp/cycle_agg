require 'rails_helper'

RSpec.describe SportGroup, type: :model do
  include_context 'seed categories'
  include_context 'HasManyChildsPolymorphic'
  include_context 'HasShortTitle'

  it 'should have_many child_sections' do
    should have_many(:sections)
      .conditions(depth: 1)
      .through(:children_associations)
      .source(:children)
  end
end
