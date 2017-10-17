# frozen_string_literal: true

# results of CountCatgegoriesInString
class MentionedCategoriesCounter
  attr_reader   :string, :categories, :terms
  attr_accessor :total_count

  def initialize
    @categories  = Hash.new(0)
    @terms       = Hash.new(0)
    @total_count = 0
  end

  def merge(other_mentioning)
    @total_count += other_mentioning.total_count
    merge_counters_results categories, other_mentioning.categories
    merge_counters_results terms,      other_mentioning.terms
    self
  end

  private

  def merge_counters_results(counters, other_counters)
    keys = counters.keys | other_counters.keys
    keys.each { |key| counters[key] += other_counters[key] }
  end
end
