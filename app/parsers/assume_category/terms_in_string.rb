# frozen_string_literal: true

module AssumeCategory
  class TermsInString
    SPLIT_TEXT_PATTERN = /[\s]+/
    MAX_PHRASE_LENGTH  = 3

    def initialize(vocabulary, max_phrase_length: nil)
      @max_phrase_length = max_phrase_length || MAX_PHRASE_LENGTH
      @vocabulary = vocabulary
    end

    def call(string)
      @words = string.downcase.split(SPLIT_TEXT_PATTERN)
      terms_from_words
    ensure
      @words = nil
    end

    private

    attr_reader :max_synonym_length, :vocabulary, :words

    def terms_from_words
      phrase_objects.map(&:terms).flatten
    end

    def phrase_objects
      vocabulary.values_at(string_phrases).compact
    end

    def string_phrases
      phrases = []
      phrase_lengths.each do |length|
        words.each_cons(length) { |words| phrases << words.join(' ') }
      end
      phrases
    end

    def phrase_lengths
      (1..max_synonym_length).to_a.reverse
    end
  end
end
