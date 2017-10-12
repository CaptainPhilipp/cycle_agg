RSpec.shared_context 'HasManyParentsPolymorphic' do
  it 'has many parent_associations' do
    should have_many(:parent_associations)
      .class_name('ChildrenParent')
      .dependent(:destroy)
  end
end
