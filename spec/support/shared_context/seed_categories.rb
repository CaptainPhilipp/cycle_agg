require "#{Rails.root}/app/seeds/seed"

RSpec.shared_context 'seed categories' do
  let(:seed_group_structs) { [Group.new('MTB', 'МТБ'), Group.new('ROAD', 'Шоссе')] }
  let(:seed_category_structs) do
    [
      Section.new(1, 'Frameset', 'Рамы и фреймсеты',   %w[MTB ROAD]),
      Subsection.new(2, 'Forks', 'Вилки',              %w[MTB ROAD] << 'Frameset'),
      Subsection.new(2, 'Suspensions', 'Амортизаторы', %w[MTB]      << 'Frameset'),

      Section.new(1, 'Guard', 'Защита',          %w[MTB]),
      Subsection.new(2, 'Rockrings', 'Рокринги', %w[MTB] << 'Guard')
    ]
  end

  let(:seed) { Seed.new }

  let!(:seed!) do
    seed.call do
      seed.write SportGroup, seed_group_structs
      seed.write Category, seed_category_structs
    end
  end

  let(:group_mtb)  { SportGroup.first }
  let(:group_road) { SportGroup.all.last }

  let(:group_mtb_sections)  { Category.sections }
  let(:group_road_sections) { Category.sections.first }

  let(:section_frameset) { Category.sections.first }
  let(:section_guard)    { Category.sections.first }

  let(:subsections_of_mtb_framesets)  { Category.subsections.first(2) }
  let(:subsections_of_road_framesets) { Category.subsections.first }

  let(:subsection_rockrings) { Category.subsections.last }
  let(:mtb_frameset_rockrings) { [group_mtb, section_frameset, subsection_rockrings] }
end
