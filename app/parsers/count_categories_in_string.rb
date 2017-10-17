# frozen_string_literal: true

# counts categories mentions in string
class CountCategoriesInString
  MAX_PHRASE_LENGTH = 3
  SPLIT_PATTERN = /[\s]+/

  def initialize(vocabulary)
    @vocabulary = vocabulary
  end

  def call(string)
    @splited_string = split_string(string)
    mentioning = MentionedCategoriesCounter.new

    count_terms_and_save_to(mentioning)
    mentioning
  end

  private

  attr_reader :splited_string, :vocabulary

  def split_string(string)
    string.downcase.split(SPLIT_PATTERN)
  end

  def count_terms_and_save_to(mentioning)
    mentioned_terms.each do |term|
      counter = term.type == 'Category' ? mentioning.categories : mentioning.terms

      term.parent_categories.each do |category|
        counter[category]      += 1
        mentioning.total_count += 1
      end
    end
  end

  def mentioned_terms
    records = []
    each_phrase do |phrase|
      vocabulary[phrase]&.each { |record| records << record }
    end
    records
  end

  def each_phrase
    phrase_sizes.each do |size|
      splited_string.each_cons(size) do |phrase_arr|
        yield phrase_arr.join(' ')
      end
    end
  end

  def phrase_sizes
    (1..MAX_PHRASE_LENGTH).to_a.reverse
  end
end
