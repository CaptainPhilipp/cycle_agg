require "#{Rails.root}/app/seeds/seed_service"

RSpec.shared_context 'seed categories' do
  let(:seed_category_structs) do
    [
      Group.new(0, 'MTB',  'МТБ'),
      Group.new(0, 'ROAD', 'Шоссе'),

      Section.new(1,    'Transmission', 'Трансмиссия', %w[MTB ROAD FUN]),
      Subsection.new(2, 'Shifters',     'Манетки', %w[MTB ROAD FUN Transmission]),
      Subsection.new(2, 'Cassetes',     'Кассеты', %w[MTB ROAD FUN Transmission]),

      Section.new(1,    'Guard',     'Защита',   %w[MTB]),
      Subsection.new(2, 'Rockrings', 'Рокринги', %w[MTB Guard])
    ]
  end

  let!(:seed) { SeedService.new.call seed_category_structs }

  let(:category_group)         { Category.groups.first }
  let(:category_sections)      { Category.sections }
  let(:category_group_section) { Category.sections.first }
  let(:category_subsection)    { Category.subsections.first }

  let(:category_group_with_hided_section) { Category.groups.last }
  let(:category_hided_section) { Category.sections.last }
end
