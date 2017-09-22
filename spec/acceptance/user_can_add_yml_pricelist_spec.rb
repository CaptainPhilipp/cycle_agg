require_relative 'acceptance_helper'
require_relative '../page_objects/new_pricelist_page'

feature 'User can upload YML pricelist' do
  let(:page_object) { NewPricelistPage.new(page).visit(new_pricelist_path) }
  let(:filepath)    { 'filepath' }

  it 'User sees file upload field and submit button' do
    expect(page_object).to have_element :attachment_file_field
    expect(page_object).to have_element :submit_button
  end

  it 'User uploads pricelist' do
    page_object.attach_file_to_attachment(filepath)
    expect(page_object.attachment).to eq filepath
  end

  it 'User uploads file with wrong format'
end
