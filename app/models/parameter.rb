class Parameter < ApplicationRecord
  include HasManyParentsPolymorphic

  def self.where_parents(parents_array)
    WhereParentsQuery.new(self).call(parents_array)
  end
end
