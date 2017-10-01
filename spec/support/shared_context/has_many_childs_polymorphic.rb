RSpec.shared_context 'HasManyChildsPolymorphic' do
  it 'should have_many children_associations' do
    should have_many(:children_associations)
      .class_name('ChildrenParent')
      .dependent(:destroy)
  end
end
