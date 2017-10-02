require_relative 'acceptance_helper'

feature 'User sees categories menu' do
  include_context 'seed categories'
  let(:seed_parameter_structs) do
    [ParameterStruct.new('Diameter', 'Диаметр', %w[MTB Guard Rockrings])]
  end

  let!(:seed_parameters) do
    seed.call do
      seed.write Parameter, seed_parameter_structs
    end
  end

  before { visit root_path }

  scenario 'When user opens category, he sees parameters of this category' do
    within '#menu' do
      click_link subsection_rockrings.ru_title
    end

    expect(page).to have_content seed_parameter_structs.first.ru_title
  end

  scenario 'When user opens category, he didn`t see parameters of another category' do
    within '#menu' do
      click_link subsections_of_mtb_framesets.last.ru_title
    end

    expect(page).to_not have_content seed_parameter_structs.first.ru_title
  end
end
