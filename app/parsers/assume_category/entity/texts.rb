# frozen_string_literal: true

class Texts
  def initialize(args); end

  # best matched sport groups
  def sport_groups; end

  # all matched sport groups
  def sport_groups_by_ratings; end

  # all matched sport groups
  def subsections; end

  # best matched sport groups
  def subsections_by_ratings; end

  def texts
    @text ||= []
  end

  def merge_texts_results; end
end
