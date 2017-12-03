# frozen_string_literal: true

module AssumeCategory
  class Text
    def initialize(vocabulary, string)
      @vocabulary = vocabulary
      @string = string
    end

    # def sport_group_by_regularity
    #   sport_group_ratings_by_regularity.last.category
    # end

    # def sport_group_ratings_by_regularity
    #   by_reglarity(sport_groups_counter)
    # end

    # def sport_group_by_mentions
    #   sport_group_ratings_by_mentions.last.category
    # end

    # def sport_group_ratings_by_mentions
    #   by_mentions(sport_groups_counter)
    # end

    def sport_group
      sport_groups_ratings.last.category
    end

    def sport_groups_ratings
      by_sum(sport_groups_counter)
    end

    def sport_groups
      sport_groups_counter.categories
    end

    # def subsection_by_regularity
    #   subsection_ratings_by_regularity.last.category
    # end

    # def subsection_ratings_by_regularity
    #   by_reglarity(subsections_counter)
    # end

    # def subsection_by_mentions
    #   subsection_ratings_by_mentions.last.category
    # end

    # def subsection_ratings_by_mentions
    #   by_mentions(subsections_counter)
    # end

    def subsection
      subsections_ratings.last.category
    end

    def subsections_ratings
      by_sum(subsections_counter)
    end

    def subsections
      subsections_counter.categories
    end

    def unknown_words
      # TODO
    end

    private

    attr_reader :category_terms, :regular_terms

    # def by_reglarity(counter)
    #   counter.by_regularity(quantile: 1.0)
    # end

    # def by_mentions(counter)
    #   counter.by_mentions(quantile: 0.35)
    # end

    def by_sum(counter)
      counter.by_rate(quentile: 0.35)
    end

    def sport_groups_counter
      @sport_groups_counter ||=
        CategoriesCounter.new(terms_in_string, categories_depth: 0,
                                               regular_weight: 1,
                                               category_weight: 3).call
    end

    def subsections_counter
      @subsections_counter ||=
        CategoriesCounter.new(terms_in_string, categories_depth: 2,
                                               regular_weight: 1,
                                               category_weight: 3).call
    end

    def terms_in_string
      @terms_in_string ||= TermsInString.new(vocabulary).call(string)
    end
  end
end
