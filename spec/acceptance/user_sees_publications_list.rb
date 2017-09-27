require_relative 'acceptance_helper'

feature 'User sees publications list' do
  include_context 'yandex_ml_example_path'
  let!(:pricelist) { Pricelist.create attachment: File.new(yandex_ml_example_path) }

  it 'When user open root page, he sees all publications' do
    visit root_path
    expect(page).to have_content title_from_ynadex_ml
  end
end