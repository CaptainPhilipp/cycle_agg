class Category < ApplicationRecord
  include HasShortTitle
  include HasManyParentsPolymorphic

  scope :sections,    -> { where(depth: 1) }
  scope :subsections, -> { where(depth: 2) }
end
