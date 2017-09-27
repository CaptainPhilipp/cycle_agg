require_relative 'acceptance_helper'

feature 'User sees publication content' do
  include_context 'yandex_ml_example_path'

  let!(:pricelist) { Pricelist.create attachment: File.new(yandex_ml_example_path) }

  scenario 'When user sees all publications, he can open page with publication' do
    visit root_path
    expect(page).to have_link title_from_ynadex_ml
  end

  context 'On page with publication, ' do
    before { visit publication_path(Publication.first) }

    scenario 'user sees main content of publication' do
      within '#page' do
        expect(page).to have_text 'First FA-5300'
        expect(page).to have_content 'Отличный подарок'
      end
    end

    scenario 'user sees advanced data of publication' do
      within '#page' do
        expect(page).to have_content 'Источник: BestSeller'
        expect(page).to have_link 'BestSeller', href: 'http://best.seller.ru/product_page.asp?pid=12348'
        expect(page).to have_content 'Доступен'
      end
    end
  end
end
