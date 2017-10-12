require "#{Rails.root}/app/seeds/seed"

RSpec.shared_context 'seed parameters' do
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
end
