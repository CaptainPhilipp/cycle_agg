class Category < ApplicationRecord
  has_many :parent_associations, as: :children,
                                 class_name: 'ChildrenParent',
                                 dependent: :destroy
  has_many :children_associations, as: :parent,
                                   class_name: 'ChildrenParent',
                                   dependent: :destroy

  has_many :child_sections,    -> { sections }, through: :children_associations,
                                                source_type: 'Category',
                                                source: :children
  has_many :child_subsections, -> { subsections }, through: :children_associations,
                                                   source_type: 'Category',
                                                   source: :children

  scope :groups,      -> { where(depth: 0) }
  scope :sections,    -> { where(depth: 1) }
  scope :subsections, -> { where(depth: 2) }

  before_save :change_short_title

  def self.includes_tree
    groups.includes child_sections: :child_subsections
  end

  private

  def change_short_title
    return unless short_title.nil?
    self.short_title = en_title.downcase.gsub(/\sand\s/, '-n-').tr(' ', '-')
  end
end
