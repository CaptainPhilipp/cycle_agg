# frozen_string_literal: true

PublicationText = Struct.new :text, :weight
DoubleResult = Struct.new :sport_group, :subsection

class AssumeByTexts
  def by_texts(texts)
    texts.map! { |text| Text.new(vocabulary, text) }

    assume_category_of(texts, :sport_groups_by_summed_ratings)
    assume_category_of(texts, :subsection_by_summed_ratings)
  end

  def by_text_pairs(_publication_texts)
    # publication_texts
    ResultsCounterHelper.modify_rate(results)
  end

  private

  def assume_category_of(texts, method)
    sum_results(texts, method).max_by(&:rate).category
  end

  def sum_results(texts, method)
    result_set = texts.map(&method)
    ResultsCounterHelper.sum_results(result_set)
  end
end
