# frozen_string_literal: true

module AssumeCategory
  class << self
    def by_texts(texts)
      AssumeByTexts.new.by_texts(texts)
    end
  end
end
