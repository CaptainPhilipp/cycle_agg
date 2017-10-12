# frozen_string_literal: true

class SportGroup < ApplicationRecord
  include HasShortTitle
  include ForVocabulary
end
