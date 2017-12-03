# frozen_string_literal: true

module AssumeCategory
  class CategoriesCounter
    Result = Struct.new :category, :score, :rate, :regular_term_weight, :category_term_weight

    def initialize(terms, categories_depth:, regular_weight: nil, category_weight: nil)
      @terms = terms
      @depth = categories_depth

      @regular_term_weight  = regular_weight  || 1
      @category_term_weight = category_weight || 3
    end

    def by_rate(regularity: 1.0, mentions: 1.0, quantile: nil)
      categories1 = by_regularity quantile: (quantile || regularity)
      categories2 = by_mentions quantile: (quantile || mentions)
      summs = ResultsCounterHelper.sum_results([categories1, categories2])
      summs.each { |result| result.rate /= 2 }
    end

    # percent of given terms that point to this category
    # can be > 1.0 cause of category_term_weight modifier for counting score
    def by_regularity(quantile: 1.0)
      cropped = cut_by_quantile(categories_sorted_by_score, quantile)
      categories = quantile == 1 ? nil : cropped.map(&:category)
      map_with_ralative_rate cropped, terms_count(categories)
    end

    # how many times this category were mentioned, in comparison with other
    # can be > 1.0 cause of category_term_weight modifier for counting score
    def by_mentions(quantile: 1.0)
      cropped = cut_by_quantile(categories_sorted_by_score, quantile)

      categories = quantile == 1 ? nil : cropped.map(&:category)
      map_with_ralative_rate cropped, category_mentions_count(categories)
    end

    def categories
      @categories ||= terms_by_category.keys
    end

    private

    attr_reader :terms, :depth, :category_scores

    def cut_by_quantile(sorted_collection, quantile = 1.0)
      ResultsCounterHelper.cut_by_total_sum(sorted_collection, :score, quantile)
    end

    def categories_sorted_by_score
      @categories_sorted_by_score ||=
        categories.map { |category| Result.new(category, category_score(category), 0) }
                  .sort_by(&:last)
    end

    # how many terms were mentioned, and relate with concrete categories
    def terms_count(categories = nil)
      if categories
        terms.count { |term| (term.categories_by_depth[depth] & categories).any? }
      else
        terms.size
      end
    end

    # how many times those categories were mentioned in terms
    def category_mentions_count(categories = nil)
      terms.inject(0) do |total, term|
        if categories
          total + (term.categories_by_depth[depth] & categories).size
        else
          total + term.categories_by_depth[depth].size
        end
      end
    end

    # build new collectioon of results, with new relative rating
    def map_with_ralative_rate(collection, delimeter)
      collection.map do |result|
        result.dup.tap { |new_result| new_result.rate = new_result.score / delimeter }
      end
    end

    def category_score(category)
      @category_scores ||= {}
      @category_scores[category] ||= begin
        directly_mentioned, indirectly_mentioned = terms_separated_by_mentioning_type(category)
        directly_mentioned.size * category_term_weight +
          indirectly_mentioned.size * regular_term_weight
      end
    end

    def terms_separated_by_mentioning_type(category)
      terms_by_category[category].partition { |term| term.category?(depth) }
    end

    def terms_by_category
      @terms_by_category ||= {}.tap do |terms_by_category|
        each_category_by_depth_in_each_term do |category, term|
          terms_by_category[category] ||= []
          terms_by_category[category] << term
        end
      end
    end

    def each_category_by_depth_in_each_term
      terms.each do |term|
        term.categories_by_depth[depth].each do |category|
          yield(category, term)
        end
      end
    end
  end
end
