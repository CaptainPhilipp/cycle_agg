require 'rails_helper'

RSpec.fdescribe CreatePublicationFromYmlJob, type: :job do
  include_context 'yandex_ml_example'

  describe '#perform' do
    let(:perform_now) { CreatePublicationFromYmlJob.perform_now(yandex_ml_example_path) }

    it 'creates Publication`s' do
      expect(perform_now).to match_array Publication.all
    end
  end
end
