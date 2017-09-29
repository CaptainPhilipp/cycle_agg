class Pricelist < ApplicationRecord
  mount_uploader :attachment, PricelistUploader
  validates :attachment, empty: false

  after_create :create_publication_from_yandex_ml

  private

  def create_publication_from_yandex_ml
    CreatePublicationFromYmlJob.perform_later(attachment.file.file)
  end
end
