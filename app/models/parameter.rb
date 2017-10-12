# frozen_string_literal: true

class Parameter < ApplicationRecord
  include HasManyParentsPolymorphic
  include ForVocabulary

  def self.where_parents(parents)
    WhereParentsQuery.new(self).call(parents)
  end
end
