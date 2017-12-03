# frozen_string_literal: true

module AssumeCategory
  class Vocabulary < Delegator
    def __getobj__
      @vocabulary
    end

    def initialize
      @vocabulary = {}
    end

    def phrases
      vocabulary.values
    end

    def [](string_phrase)
      vocabulary[string_phrase.downcase]
    end

    def values_at(*string_phrases)
      string_phrases = string_phrases.first if string_phrases.first.is_a?(Array)
      vocabulary.values_at(*string_phrases.map(&:downcase))
    end

    def fill(records)
      records.each { |record| add(record) }
      self
    end

    def add(record)
      add_term_phrases Entity::Term.new(record)
      self
    end

    private

    attr_reader :vocabulary

    def add_term_phrases(term)
      term.phrases.each do |string|
        if (phrase_in_vocab = vocabulary[string])
          phrase_in_vocab.add_term(term)
        else
          vocabulary[string] = Entity::Phrase.new(string).add_term(term)
        end
      end
      self
    end
  end
end
