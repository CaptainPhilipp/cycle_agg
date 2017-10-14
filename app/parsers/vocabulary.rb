# frozen_string_literal: true

# Stores objects, that have attribute with all titles and title synonyms
# Returns objects, that have element in theirs collections
#
# term is an any object, represents data. For example, it is Record,
# responds to :all_phrases, that returns record titles and synonyms.
class Vocabulary < Delegator
  def __getobj__
    @vocabulary
  end

  def initialize
    @vocabulary = {}
  end

  def [](phrase)
    vocabulary[phrase.downcase]
  end

  def fill(terms)
    terms.each { |term| add(term) }
    self
  end

  def add(term)
    phrases_of(term).each do |phrase|
      phrase = phrase.downcase
      vocabulary[phrase] ||= []
      vocabulary[phrase] << term
    end
    self
  end

  private

  attr_reader :vocabulary

  def phrases_of(term)
    term.all_words
  end
end
