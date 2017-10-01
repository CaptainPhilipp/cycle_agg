class Category < ApplicationRecord
  include HasShortTitle
  include HasManyChildsPolymorphic

  has_many :parent_associations, as: :children,
                                 class_name: 'ChildrenParent',
                                 dependent: :destroy

  scope :sections,    -> { where(depth: 1) }
  scope :subsections, -> { where(depth: 2) }
end
