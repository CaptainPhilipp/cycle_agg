require_relative 'acceptance_helper'

feature 'User sees categories menu' do
  include_context 'seed categories'

  scenario 'Test seeded correctly' do
    expect(Category.count).to_not be_zero
  end

  context 'When user open root page, ' do
    before { visit root_path }

    scenario 'user sees menu' do
      within '#menu' do
        Category.all.each do |group|
          expect(page).to have_content group.ru_title
        end
      end
    end
  end
end
