class Pricelist < ApplicationRecord
  mount_uploader :attachment, PricelistUploader
  validates :attachment, presence: true, format: /.+\.yml/i
end
