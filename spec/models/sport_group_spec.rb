require 'rails_helper'

RSpec.describe SportGroup, type: :model do
  include_context 'seed categories'
  include_context 'HasManyChildsPolymorphic'
  include_context 'HasShortTitle'
end
