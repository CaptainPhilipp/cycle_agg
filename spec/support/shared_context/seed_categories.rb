require "#{Rails.root}/app/seeds/seed_service"

RSpec.shared_context 'seed categories' do
  let(:seed_category_structs) do
    [
      Group.new(0, 'MTB',  'МТБ'),
      Group.new(0, 'ROAD', 'Шоссе'),

      Section.new(1, 'Frameset', 'Рамы и фреймсеты',   %w[MTB ROAD]),
      Subsection.new(2, 'Forks', 'Вилки',              %w[MTB ROAD] << 'Frameset'),
      Subsection.new(2, 'Suspensions', 'Амортизаторы', %w[MTB]      << 'Frameset'),

      Section.new(1, 'Guard', 'Защита',          %w[MTB]),
      Subsection.new(2, 'Rockrings', 'Рокринги', %w[MTB] << 'Guard')
    ]
  end

  let!(:seed) { SeedService.new.call seed_category_structs }

  let(:group_mtb)  { SportGroup.all.first }
  let(:group_road) { SportGroup.all.last }

  let(:group_mtb_sections)  { Category.sections }
  let(:group_road_sections) { Category.sections.first }

  let(:section_frameset) { Category.sections.first }
  let(:section_guard)    { Category.sections.first }

  let(:subsections_of_mtb_framesets)  { Category.subsections.first(2) }
  let(:subsections_of_road_framesets) { Category.subsections.first }
end
