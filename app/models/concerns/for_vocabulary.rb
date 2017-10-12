# frozen_string_literal: true

module ForVocabulary
  extend ActiveSupport::Concern

  included do
    has_many :synonyms, as: :owner
    scope :for_vocabulary, -> { includes(:synonyms, :parent_associations) }
  end

  def all_words
    ([en_title, ru_title] + synonyms.map(&:value)).compact
  end

  def type
    self.class.to_s
  end
end
