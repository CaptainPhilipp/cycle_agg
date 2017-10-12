require_relative 'acceptance_helper'

feature 'User sees values of chosen categories' do
  include_context 'seed parameters'

  let(:searcheable_title) { seed_list_values_structs.first.ru_title }

  before { visit root_path }

  scenario 'When user opens category, he sees parameters of this category' do
    within '#menu' do
      find_all('a', text: subsection_forks.ru_title).first.click
    end

    expect(page).to have_content searcheable_title
  end

  scenario 'When user opens category, he didn`t see parameters of another category' do
    within '#menu' do
      click_link section_guard.ru_title
    end

    expect(page).to_not have_content searcheable_title
  end
end
