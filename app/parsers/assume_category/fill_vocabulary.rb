# frozen_string_literal: true
# frozen_string_literal: true

module AssumeCategory
  # Creates filled from database vocabulary
  class FillVocabulary
    delegate :call, to: :new

    def call(vocabulary = Entity::Vocabulary.new)
      vocabulary.fill(records)
      vocabulary
    end

    private

    def records
      prepare_collections.flatten
    end

    def prepare_collections
      collection_constants.map(&:for_vocabulary)
    end

    def collection_constants
      [Category.subsections, Parameter, ListValue]
    end
  end
end
