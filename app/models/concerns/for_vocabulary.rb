# frozen_string_literal: true

module ForVocabulary
  extend ActiveSupport::Concern

  included do
    has_many :synonyms, as: :owner
    has_many :parent_categories, through: :parent_associations,
                                 source: :parent,
                                 source_type: 'Category'
    scope :for_vocabulary, -> { includes(:synonyms, :parent_associations) }
  end

  def all_words
    ([en_title, ru_title] + synonyms.map(&:value)).compact
  end

  def type
    self.class.to_s
  end

  def parent_categories
    is_a?(Category) ? [self] : super
  end
end
