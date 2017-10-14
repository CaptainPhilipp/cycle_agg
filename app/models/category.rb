# frozen_string_literal: true

class Category < ApplicationRecord
  include HasShortTitle
  include HasManyParentsPolymorphic
  include ForVocabulary

  scope :sections,    -> { where(depth: 1) }
  scope :subsections, -> { where(depth: 2) }

  def parent_categories
    [self]
  end
end
