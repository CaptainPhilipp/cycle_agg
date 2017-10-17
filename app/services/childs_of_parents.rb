# frozen_string_literal: true

# Presents categories in right structure, with relations. Optimized.
class ChildsOfParents
  def initialize(indexed_childrens, indexed_relations)
    @indexed_childrens = indexed_childrens
    @indexed_relations = indexed_relations

    raise ArgumentError unless indexed_childrens.is_a? IndexedCollection
    raise ArgumentError unless indexed_relations.is_a? IndexedCollection
  end

  def for_parents(*parents)
    parents.compact!
    raise ArgumentError, 'Given array of records is empty' if parents.empty?

    indexed_childrens.by_key(id: common_child_ids_of(parents))
  end

  private

  attr_reader :indexed_childrens, :indexed_relations

  def common_child_ids_of(parents)
    return child_ids(parents.first) if parents.size == 1
    parents.map { |parent| child_ids(parent) }.inject { |ids, parent| ids & parent }
  end

  def child_ids(parent)
    indexed_relations.by_keys(keys_for(parent)).compact.map(&:children_id)
  end

  def keys_for(parent)
    { children_type: childs_type, parent_id: parent.id, parent_type: parent.class.to_s }
  end

  def childs_type
    @childs_type ||= indexed_childrens.first.class.to_s
  end
end
