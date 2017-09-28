require_relative 'acceptance_helper'

feature 'User sees publication content' do
  include_context 'yandex_ml_example_path'

  let!(:pricelist) { Pricelist.create attachment: File.new(yandex_ml_example_path) }

  scenario 'When user sees all publications, he can open page with publication' do
    visit root_path
    expect(page).to have_link yandex_ml_offer.title
  end

  context 'On page with publication, ' do
    before { visit publication_path(Publication.first) }

    scenario 'user sees main content of publication' do
      within '#page' do
        expect(page).to have_text    yandex_ml_offer.title
        expect(page).to have_content yandex_ml_offer.description
      end
    end

    scenario 'user sees advanced data of publication' do
      within '#page' do
        expect(page).to have_content "Источник: #{yandex_ml_shop_title}"
        expect(page).to have_link    yandex_ml_shop_title, href: yandex_ml_offer.url
        expect(page).to have_content yandex_ml_offer.available ? 'Доступен' : 'Не доступен'
      end
    end
  end
end
