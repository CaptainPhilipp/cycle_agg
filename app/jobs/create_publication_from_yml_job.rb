# frozen_string_literal: true

class CreatePublicationFromYmlJob < ApplicationJob
  queue_as :default

  def perform(filepath)
    hashes = HashFromYML.call(filepath)
    Publication.create(hashes)
  end
end
