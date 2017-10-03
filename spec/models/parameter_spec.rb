require 'rails_helper'

RSpec.describe Parameter, type: :model do
  include_context 'has localizeable title'

  it { should have_db_column :values_type }
end
