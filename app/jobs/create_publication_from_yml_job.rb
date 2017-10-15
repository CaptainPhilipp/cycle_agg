# frozen_string_literal: true

class CreatePublicationFromYmlJob < ApplicationJob
  queue_as :default

  def perform(filepath)
    parser = YandexMl::Parser.new(filepath)
    hashes = YandexMl::OffersHashes.call(parser.yml)
    Publication.create(hashes)
  ensure
    parser.close
  end
end
