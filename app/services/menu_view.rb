# frozen_string_literal: true

# Presents categories in right structure, with relations. Optimized.
class MenuView
  def initialize(indexed_childrens, indexed_relations)
    @indexed_childrens = indexed_childrens
    @indexed_relations = indexed_relations
    raise ArgumentError if indexed_childrens.nil? || indexed_relations.nil?
  end

  def for_parents(*parents)
    parents.compact!
    raise ArgumentError, 'Given array of records is empty' if parents.empty?
    ids = common_child_ids_of(parents)
    indexed_childrens.by_keys(id: ids)
  end

  private

  attr_reader :indexed_childrens, :indexed_relations

  def common_child_ids_of(parents)
    return child_ids(parents.first) if parents.size == 1

    start_ids = child_ids(parents.shift)
    parents.inject(start_ids) { |ids, parent| ids & child_ids(parent) }
  end

  def child_ids(parent)
    indexed_relations
      .collection_by_key(parent_id: parent.id,
                         parent_type: parent.class.to_s,
                         children_type: childs_type)
      .compact
      .map(&:children_id)
  end

  def childs_type
    @childs_type ||= indexed_childrens.first.class.to_s
  end
end
