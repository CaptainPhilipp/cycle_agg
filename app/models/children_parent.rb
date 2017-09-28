class ChildrenParent < ApplicationRecord
  belongs_to :parent,   polymorphic: true
  belongs_to :children, polymorphic: true
end
