class Category < ApplicationRecord
  include HasShortTitle
  include HasManyChildsPolymorphic

  has_many :parent_associations, as: :children,
                                 class_name: 'ChildrenParent',
                                 dependent: :destroy

  has_many :sections, -> { sections }, through: :children_associations,
                                       source_type: 'Category',
                                       source: :parent
  has_many :subsections, -> { subsections }, through: :children_associations,
                                             source_type: 'Category',
                                             source: :children

  scope :sections,    -> { where(depth: 1) }
  scope :subsections, -> { where(depth: 2) }
end
