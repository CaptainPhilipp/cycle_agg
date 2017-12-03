# frozen_string_literal: true

class SportGroup < ApplicationRecord
  include HasShortTitle
  include ForVocabulary

  def depth
    0
  end
end
