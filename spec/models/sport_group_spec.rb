require 'rails_helper'

RSpec.describe SportGroup, type: :model do
  include_context 'seed categories'
  include_context 'has localizeable title'
  include_context 'HasShortTitle'
  include_context 'for vocabulary'
end
