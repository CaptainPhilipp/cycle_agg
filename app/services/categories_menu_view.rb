# Presents categories in right structure, with relations. Optimized.
class CategoriesMenuView
  def initialize(collection)
    @raw_collection = collection
  end

  def sections_for(*parents)
    for_parents(parents, 1)
  end

  def subsections_for(*parents)
    for_parents(parents, 2)
  end

  private

  def for_parents(parents, depth)
    ids = parents.size > 1 ? child_ids_intersection(parents) : child_ids(parents.first)

    indexed_collection(depth).by_pks(ids)
  end

  def indexed_collection(depth)
    @collections ||= {}
    @collections[depth] ||= IndexedCollection.new grouped_by_depth[depth]
  end

  def grouped_by_depth
    @grouped_by_depth ||= @raw_collection.to_a.group_by(&:depth)
  end

  def child_ids_intersection(parents)
    start_ids = child_ids(parents.shift)
    parents.inject(start_ids) { |ids, parent| ids & child_ids(parent) }
  end

  def child_ids(parent)
    indexed_relations.by_fk(parent.id).map(&:children_id)
  end

  def indexed_relations
    @indexed_relations ||= IndexedRelationsCollection.new relations, fk: :parent_id
  end

  def relations
    @relations ||=
      ChildrenParent.where(children_type: 'Category', parent_type: %w[Category SportGroup])
  end
end
