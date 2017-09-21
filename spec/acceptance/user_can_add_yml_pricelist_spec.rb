require_relative 'acceptance_helper'

feature 'User can upload YML pricelist' do
  it 'User sees file upload field and submit button' do
    visit new_pricelist_path
    expect(page).to have_selector('input[type=file]')
    expect(page).to have_button('Upload pricelist')
  end
end
