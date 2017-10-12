# frozen_string_literal: true

# Creates and fills vocabulary from database
class BuildVocabulary
  FOR_VOCABULARY_SCOPE = :for_vocabulary

  def call
    Vocabulary.new.tap { |vocabulary| vocabulary.fill(records) }
  end

  def self.call
    new.call
  end

  private

  def records
    prepare_collections.flatten
  end

  def prepare_collections
    collections.map(&FOR_VOCABULARY_SCOPE)
  end

  def collections
    [Category.subsections, Parameter, ListValue]
  end
end
