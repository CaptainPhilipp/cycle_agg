# frozen_string_literal: true

module ForVocabulary
  extend ActiveSupport::Concern

  included do
    scope :for_vocabulary, -> { includes(:synonym, :parent_associations) }
  end

  def all_words
    [en_title, ru_title] + synonims.map(:value)
  end

  def type
    self.class.to_s
  end
end
