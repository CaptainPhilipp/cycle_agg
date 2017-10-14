# frozen_string_literal: true

# At first, tries to find category title in given string, and returns category.
# If not found, finds categories of terms, listed in title
# and returns common category of listed terms
class CategoriesFromString
  MAX_PHRASE_LENGTH = 3
  SPLIT_PATTERN = /[\s]+/

  attr_reader :categories, :terms, :total_count

  def initialize(vocabulary = nil)
    @vocabulary = vocabulary || BuildVocabulary.call
  end

  def call(string)
    @string = string
    @categories = Hash.new(0)
    @terms      = Hash.new(0)
    @total_count = 0

    count_terms
    self
  end

  private

  attr_reader :string, :vocabulary

  def count_terms
    mentioned_terms.each do |term|
      counter = term.type == 'Category' ? @categories : @terms
      term.parent_categories.each do |category|
        counter[category] += 1
        @total_count      += 1
      end
    end
  end

  def mentioned_terms
    @mentioned_terms ||= [].tap do |records|
      each_phrase do |phrase|
        vocabulary[phrase]&.each { |record| records << record }
      end
    end
  end

  def each_phrase
    phrase_sizes.each do |size|
      string.downcase.split(SPLIT_PATTERN).each_cons(size) do |phrase_arr|
        yield phrase_arr.compact.join(' ').chomp
      end
    end
  end

  def phrase_sizes
    (1..MAX_PHRASE_LENGTH).to_a.reverse
  end
end
