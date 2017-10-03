# frozen_string_literal: true

# gives access to relation records by foreign_key
class IndexedRelationsCollection
  attr_reader :relations, :fk_name

  def initialize(relations, fk:)
    raise ArgumentError unless relations.respond_to? :each
    @relations = relations
    @fk_name = fk
  end

  def by_fk(value)
    indexed_relations[value]
  end

  private

  def indexed_relations
    @indexed_relations ||= index_relations
  end

  def index_relations
    hash = {}
    relations.each do |relation|
      fk = fk_of relation
      hash[fk] ||= []
      hash[fk] << relation
    end
    hash
  end

  def fk_of(relation)
    relation.send fk_name
  end
end
