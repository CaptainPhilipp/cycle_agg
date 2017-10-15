# frozen_string_literal: true

class CreatePublicationFromYmlJob < ApplicationJob
  queue_as :default

  def perform(filepath)
    service = HashFromYML.call(filepath)
    Publication.create(service.offers)
  end
end
