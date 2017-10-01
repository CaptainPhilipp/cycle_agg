class Category < ApplicationRecord
  include HasShortTitle
  include HasManyChildsPolymorphic

  scope :sections,    -> { where(depth: 1) }
  scope :subsections, -> { where(depth: 2) }
end
