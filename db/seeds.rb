class Seed
  attr_reader :records, :relations

  def self.transaction(*models)
    models.first.transaction do
      models.each(&:delete_all)

      yield new
    end
  end

  def initialize
    @records = {}
    @relations = {}
  end

  def write(record, parent_pks = nil)
    pk = pk_for record

    records[pk]   = record
    relations[pk] = parent_pks if parent_pks
  end

  def each_relation
    relations.each do |children_pk, parent_pks|
      children = by_pk(children_pk)

      parent_pks.each do |parent_pk|
        parent = by_pk(parent_pk)
        yield children, parent
      end
    end
  end

  private

  def pk_for(record)
    record.en_title
  end

  def by_pk(pk)
    records[pk]
  end
end

Group      = Struct.new :depth, :en_title, :ru_title
Section    = Struct.new :depth, :en_title, :ru_title, :parent_titles
Subsection = Struct.new :depth, :en_title, :ru_title, :parent_titles

# rubocop:disable Metrics/LineLength, Layout/EmptyLines
# rubocop:disable Layout/SpaceInsideArrayPercentLiteral, Layout/SpaceInsidePercentLiteralDelimiters

categories = [
  Group.new(0, 'MTB',  'МТБ'),
  Group.new(0, 'ROAD', 'Шоссе'),
  Group.new(0, 'BMX',  'BMX'),
  Group.new(0, 'FUN',  'Прогулочные'),


  Section.new(1,    'Frame and framesets', 'Рамы и фреймсеты',          %w[MTB ROAD BMX FUN]),

  Subsection.new(2, 'Framesets',           'Фреймсет',                  %w[MTB ROAD BMX FUN] << 'Frame and framesets'),
  Subsection.new(2, 'Frames',              'Рамы',                      %w[MTB ROAD BMX FUN] << 'Frame and framesets'),
  Subsection.new(2, 'Forks',               'Вилки',                     %w[MTB ROAD BMX FUN] << 'Frame and framesets'),
  Subsection.new(2, 'Suspensions',         'Амортизаторы',              %w[MTB]              << 'Frame and framesets'),
  Subsection.new(2, 'Frame details',       'Запчасти для рам',          %w[MTB ROAD BMX FUN] << 'Frame and framesets'),
  Subsection.new(2, 'Fork coils',          'Пружины для вилки',         %w[MTB]              << 'Frame and framesets'),
  Subsection.new(2, 'Fork details',        'Запчасти для вилки',        %w[MTB ROAD BMX FUN] << 'Frame and framesets'),
  Subsection.new(2, 'Suspension coils',    'Пружины для амортизатора',  %w[MTB]              << 'Frame and framesets'),
  Subsection.new(2, 'Suspension details',  'Запчасти для амортизатора', %w[MTB]              << 'Frame and framesets'),


  Section.new(1,    'Wheels and wheelsets', 'Колёса',                %w[MTB ROAD BMX FUN]),

  Subsection.new(2, 'Wheelsets',            'Наборы колес',          %w[MTB ROAD BMX FUN] << 'Wheels and wheelsets'),
  Subsection.new(2, 'Wheels',               'Колёса',                %w[MTB ROAD BMX FUN] << 'Wheels and wheelsets'),
  Subsection.new(2, 'Rims',                 'Рамы',                  %w[MTB ROAD BMX FUN] << 'Wheels and wheelsets'),
  Subsection.new(2, 'Hubs',                 'Втулки',                %w[MTB ROAD BMX FUN] << 'Wheels and wheelsets'),
  Subsection.new(2, 'Spokes',               'Спицы',                 %w[MTB ROAD BMX FUN] << 'Wheels and wheelsets'),
  Subsection.new(2, 'Nippels',              'Ниппели',               %w[MTB ROAD BMX FUN] << 'Wheels and wheelsets'),
  Subsection.new(2, 'Tires',                'Покрышки',              %w[MTB ROAD BMX FUN] << 'Wheels and wheelsets'),
  Subsection.new(2, 'Tubes',                'Камеры',                %w[MTB ROAD BMX FUN] << 'Wheels and wheelsets'),
  Subsection.new(2, 'Tubeless kits',        'Наборы для бескамерки', %w[MTB ROAD     FUN] << 'Wheels and wheelsets'),
  Subsection.new(2, 'Caps',                 'Колпачки',              %w[MTB ROAD BMX FUN] << 'Wheels and wheelsets'),
  Subsection.new(2, 'Rim tapes',            'Ободная лента',         %w[MTB ROAD BMX FUN] << 'Wheels and wheelsets'),
  Subsection.new(2, 'Axles',                'Оси',                   %w[MTB ROAD BMX FUN] << 'Wheels and wheelsets'),
  Subsection.new(2, 'QR',                   'Эксцентрики',           %w[MTB ROAD BMX FUN] << 'Wheels and wheelsets'),
  Subsection.new(2, 'Wheels details',       'Запчасти для колёс',    %w[MTB ROAD BMX FUN] << 'Wheels and wheelsets'),


  Section.new(1,    'Drive',           'Привод',               %w[MTB ROAD BMX FUN]),

  Subsection.new(2, 'Cranksets',       'Системы',              %w[MTB ROAD BMX FUN Drive]),
  Subsection.new(2, 'Pedals',          'Педали',               %w[MTB ROAD BMX FUN Drive]),
  Subsection.new(2, 'Bottom brackets', 'Каретки',              %w[MTB ROAD BMX FUN Drive]),
  Subsection.new(2, 'Powermeters',     'Измерители мощности',  %w[    ROAD         Drive]),
  Subsection.new(2, 'Cranks',          'Шатуны',               %w[MTB ROAD BMX FUN Drive]),
  Subsection.new(2, 'Chains',          'Цепи',                 %w[MTB ROAD BMX FUN Drive]),
  Subsection.new(2, 'Chainring bolts', 'Бонки',                %w[MTB ROAD BMX FUN Drive]),
  Subsection.new(2, 'Drive details',   'Запчасти для привода', %w[MTB ROAD BMX FUN Drive]),


  Section.new(1,    'Transmission',             'Трансмиссия',              %w[MTB ROAD FUN]),

  Subsection.new(2, 'Transmission sets',        'Наборы трансмиссии',       %w[MTB ROAD FUN Transmission]),
  Subsection.new(2, 'Cassetes',                 'Кассеты',                  %w[MTB ROAD FUN Transmission]),
  Subsection.new(2, 'Single cassete rings',     'Отельные звезды',          %w[MTB ROAD FUN Transmission]),
  Subsection.new(2, 'Rear derailers',           'Задние переключатели',     %w[MTB ROAD FUN Transmission]),
  Subsection.new(2, 'Front derailers',          'Передние переключатели',   %w[MTB ROAD FUN Transmission]),
  Subsection.new(2, 'Shifters',                 'Манетки',                  %w[MTB ROAD FUN Transmission]),
  Subsection.new(2, 'Gear cable sets',          'Наборы рубашек и тросов',  %w[MTB ROAD FUN Transmission]),
  Subsection.new(2, 'Gear outer cable casings', 'Рубашки переключателя',    %w[MTB ROAD FUN Transmission]),
  Subsection.new(2, 'Gear inner cables',        'Тросы переклчателя',       %w[MTB ROAD FUN Transmission]),
  Subsection.new(2, 'Gear details',             'Запчасти для трансмиссии', %w[MTB ROAD FUN Transmission]),


  Section.new(1,    'Cockpit',        'Кокпит',             %w[MTB ROAD BMX FUN]),

  Subsection.new(2, 'Bars',           'Рули',               %w[MTB ROAD BMX FUN Cockpit]),
  Subsection.new(2, 'Stems',          'Выносы',             %w[MTB ROAD BMX FUN Cockpit]),
  Subsection.new(2, 'Headsets',       'Рулевые колонки',    %w[MTB ROAD BMX FUN Cockpit]),
  Subsection.new(2, 'Grips',          'Грипсы',             %w[MTB ROAD BMX FUN Cockpit]),
  Subsection.new(2, 'Bars and plugs', 'Заглушки руля',      %w[MTB ROAD BMX FUN Cockpit]),
  Subsection.new(2, 'Barends',        'Рожки руля',         %w[MTB ROAD BMX FUN Cockpit]),
  Subsection.new(2, 'Saddles',        'Седло',              %w[MTB ROAD BMX FUN Cockpit]),
  Subsection.new(2, 'Seatposts',      'Подседельный штырь', %w[MTB ROAD BMX FUN Cockpit]),


  Section.new(1,    'Brakes and sets', 'Тормоза',            %w[MTB ROAD BMX FUN]),

  Subsection.new(2, 'Brake set',       'Комплекты тормозов', %w[MTB ROAD BMX FUN] << 'Brakes and sets'),
  Subsection.new(2, 'Brakes',          'Тормоза',            %w[MTB ROAD BMX FUN] << 'Brakes and sets'),
  Subsection.new(2, 'Rotors',          'Роторы',             %w[MTB ROAD BMX FUN] << 'Brakes and sets'),
  Subsection.new(2, 'Adapters',        'Адаптеры',           %w[MTB ROAD BMX FUN] << 'Brakes and sets'),
  Subsection.new(2, 'Levers',          'Тормозные ручки',    %w[MTB ROAD BMX FUN] << 'Brakes and sets'),
  Subsection.new(2, 'Calipers',        'Калиперы',           %w[MTB ROAD BMX FUN] << 'Brakes and sets'),
  Subsection.new(2, 'Brakepads',       'Тормозные колодки',  %w[MTB ROAD BMX FUN] << 'Brakes and sets'),
  Subsection.new(2, 'Brake Hoses',     'Гидролинии',         %w[MTB ROAD BMX FUN] << 'Brakes and sets'),


  Section.new(1,    'Guard',           'Защита',               %w[MTB]),

  Subsection.new(2, 'Rockrings',       'Рокринги',             %w[MTB Guard]),
  Subsection.new(2, 'Bashguards',      'Башгарды',             %w[MTB Guard]),
  Subsection.new(2, 'Chainstays',      'Успокоители',          %w[MTB Guard]),
  Subsection.new(2, 'Derailer guards', 'Защита переключателя', %w[MTB Guard])
]

# rubocop:enable Metrics/LineLength, Layout/EmptyLines
# rubocop:enable Layout/SpaceInsideArrayPercentLiteral, Layout/SpaceInsidePercentLiteralDelimiters

def hash_from(struct)
  struct.to_h.select { |key, _| %i[ru_title en_title depth].include? key }
end

def pks(struct, key_name = :parent_titles)
  struct.send key_name if struct.respond_to? key_name
end

Seed.transaction Category, ChildrenParent do |seed|
  categories.each do |struct|
    record = Category.create hash_from(struct)
    seed.write record, pks(struct)
  end

  seed.each_relation do |children, parent|
    ChildrenParent.create children: children, parent: parent
  end
end
