RSpec.shared_context 'has localizeable title' do
  it { should have_db_column :ru_title }
  it { should have_db_column :en_title }
end
