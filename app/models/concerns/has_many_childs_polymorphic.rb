module HasManyChildsPolymorphic
  extend ActiveSupport::Concern

  included do
    has_many :children_associations, as: :parent,
                                     class_name: 'ChildrenParent',
                                     dependent: :destroy
  end
end
