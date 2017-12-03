# frozen_string_literal: true

module AssumeCategory
  class Term
    attr_reader :record

    SPORT_GROUP_DEPTH = 0
    SUBSECTION_DEPTH  = 2

    def initialize(record)
      @record = record
    end

    def phrases
      (titles + synonims).compact.map(&:downcase)
    end

    def categories_by_depth
      @categories_by_depth ||= all_parent_categories.group_by(&:depth)
    end

    def category?(depth:)
      (record.is_a?(SportGroup) && depth == 1) ||
        (record.is_a?(Category) && depth == record.depth)
    end

    private

    def titles
      [record.en_title, record.ru_title]
    end

    def synonims
      record.synonyms.map(&:value)
    end

    def all_parent_categories
      @all_parent_categories ||= category? ? parent_categories << record : parent_categories
    end

    def parent_categories
      record.parent_categories.to_a + record.parent_sport_groups.to_a
    end
  end
end
