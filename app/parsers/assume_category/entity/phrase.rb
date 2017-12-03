# frozen_string_literal: true

module AssumeCategory
  class Phrase < Delegator
    attr_reader :phrase

    def __getobj__
      @phrase
    end

    def initialize(phrase)
      @phrase = phrase
      @terms  = []
    end

    alias value phrase

    def add_term(term)
      @terms << term
      self
    end

    # def categories
    #   terms.each_with_object([]) { |term, arr| arr.contact(term.categories) }
    # end

    def single_type?
      types.size == 1 && true || false
    end

    private

    attr_reader :terms
  end
end
