require 'rails_helper'

RSpec.describe Parameter, type: :model do
  include_context 'has localizeable title'
  include_context 'for vocabulary'

  it { should have_db_column(:values_type).with_options(null: false) }
  it { should have_db_column(:present_type).with_options(null: true) }
end
