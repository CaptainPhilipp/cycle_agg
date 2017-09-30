class SportGroup < ApplicationRecord
  include HasShortTitle
  include HasManyChildsPolymorphic

  has_many :sections, -> { sections }, through: :children_associations,
                                       source_type: 'Category',
                                       source: :children

  def self.includes_tree
    includes sections: :subsections
  end
end
