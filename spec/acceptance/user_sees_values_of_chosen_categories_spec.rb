require_relative 'acceptance_helper'

feature 'User sees values of chosen categories' do
  include_context 'seed categories'

  let(:seed_parameter_structs) do
    [ParameterStruct.new('Dampher', 'Демпфер', 'ListValue', %w[MTB Frameset Forks])]
  end

  let(:seed_list_values_structs) do
    [ListValueStruct.new('Coil', 'Пружина',         %w[MTB Frameset Forks Dampher]),
     ListValueStruct.new('Air', 'Воздушная камера', %w[MTB Frameset Forks Dampher])]
  end

  let!(:seed_parameters) do
    seed.call do
      seed.write Parameter, seed_parameter_structs
      seed.write ListValue, seed_list_values_structs
    end
  end

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
