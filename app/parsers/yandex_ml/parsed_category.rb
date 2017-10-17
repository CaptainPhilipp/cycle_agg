# frozen_string_literal: true

module YandexMl
  # wrapper for YML parser library output element
  class ParsedCategory < Deleagtor
    attr_reader :mentioned_categories, :category, :offers
    attr_accessor :parent

    def __getobj__
      @category
    end

    def initialize(category, mentioned_categories)
      @mentioned_categories = mentioned_categories
      @category = category
      @offers ||= []
    end

    def all_mentioned_categories
      mentionings_from_elements.inject { |memo, mentioning| memo.merge(mentioning) }
    end

    protected

    def mentionings_from_elements
      from_offers  = @offers.map(&:mentioned_categories)
      from_parents = parents_mentioned_categories
      from_self    = mentioned_categories

      from_offers + from_parents << from_self
    end

    def parents_mentioned_categories(collected_mentionings: [])
      if parent_id
        collected_mentionings << parent.mentioned_categories
        parent.parents_mentioned_categories(collected_mentionings: collected_mentionings)
      else
        collected_mentionings
      end
    end
  end
end
