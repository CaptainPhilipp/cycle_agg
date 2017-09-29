class CreatePublicationFromYmlJob < ApplicationJob
  queue_as :default

  def perform(filepath)
    hashes = HashFromYandexMl.new.call(filepath)
    Publication.create(hashes)
  end
end
