module HasManyParentsPolymorphic
  extend ActiveSupport::Concern

  included do
    has_many :parent_associations, as: :children,
                                   class_name: 'ChildrenParent',
                                   dependent: :destroy
  end
end
