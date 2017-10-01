require 'rails_helper'

RSpec.describe ChildrenParent, type: :model do
  it { should belong_to(:parent) }
  it { should belong_to(:children) }
end
