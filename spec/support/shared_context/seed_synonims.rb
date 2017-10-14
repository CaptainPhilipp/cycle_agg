require "#{Rails.root}/app/seeds/seed"

RSpec.shared_context 'seed synonyms' do
  include_context 'seed parameters'

  def find_by(en_title, model)
    model.where(en_title: en_title).first
  end

  let(:seed_synonyms_structs) do
    [
      SynonymStruct.new('Пружина',   find_by('Dampher', Parameter)),
      SynonymStruct.new('Воздух',    find_by('Air',     ListValue)),
      SynonymStruct.new('Воздушная', find_by('Air',     ListValue)),
      SynonymStruct.new('Вилка',     find_by('Forks',   Category))
    ]
  end

  let!(:seed_synonyms) do
    Synonym.create(seed_synonyms_structs.map { |s| { value: s.value, owner: s.owner } })
  end
end
