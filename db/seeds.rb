# frozen_string_literal: true

require_relative '../app/seeds/seed'

# rubocop:disable Layout/EmptyLines, Metrics/LineLength
# rubocop:disable Layout/SpaceInsideArrayPercentLiteral, Layout/SpaceInsidePercentLiteralDelimiters

groups = [
  Group.new('MTB',  'МТБ'),
  Group.new('ROAD', 'Шоссе'),
  Group.new('BMX',  'BMX'),
  Group.new('FUN',  'Прогулочные')
]

categories = [
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

parameters = []
list_values = []

parameters << ParameterStruct.new('Frame type',       'Тип рамы',   ['MTB', 'Frame and framesets', 'Frames'])
list_values << ListValueStruct.new('Hardtail',        'Хардтейл',   ['MTB', 'Frame and framesets', 'Frames', 'Frame type'])
list_values << ListValueStruct.new('Full suspension', 'Двухподвес', ['MTB', 'Frame and framesets', 'Frames', 'Frame type'])


parameters << ParameterStruct.new('Material',   'Материал', ['MTB', 'Frame and framesets', 'Frames'])
list_values << ListValueStruct.new('Aluminium', 'Алюминий', ['MTB', 'Frame and framesets', 'Frames', 'Material'])
list_values << ListValueStruct.new('Steel',     'Сталь',    ['MTB', 'Frame and framesets', 'Frames', 'Material'])
list_values << ListValueStruct.new('Carbon',    'Карбон',   ['MTB', 'Frame and framesets', 'Frames', 'Material'])
list_values << ListValueStruct.new('Titanium',  'Титан',    ['MTB', 'Frame and framesets', 'Frames', 'Material'])


Seed.call do |seed|
  seed.write(SportGroup, groups)
  seed.write(Category, categories)
  seed.write(Parameter, parameters)
  seed.write(ListValue, list_values)
end
