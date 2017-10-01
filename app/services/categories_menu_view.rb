# Presents categories in right structure, with relations. Optimized.
class CategoriesMenuView
  def initialize(collection, groups:)
    @root_categories = groups
    @raw_collection = collection
  end

  def groups
    @root_categories
  end

  def sections_for(*parents)
    for_parents(parents, indexed_sections)
  end

  def subsections_for(*parents)
    for_parents(parents, indexed_subsections)
  end

  private

  def for_parents(parents, indexed_collection)
    ids = parents.size > 1 ? child_ids_intersection(parents) : child_ids(parents.first)
    indexed_collection.by_pks ids
  end

  def child_ids_intersection(parents)
    start_ids = child_ids(parents.shift)
    parents.inject(start_ids) { |ids, parent| ids & child_ids(parent) }
  end

  def child_ids(parent)
    indexed_relations.by_fk(parent.id, :parent_id).map(&:children_id)
  end

  def indexed_sections
    @indexed_sections ||= IndexedCollection.new with_depth 1
  end

  def indexed_subsections
    @indexed_subsections ||= IndexedCollection.new with_depth 2
  end

  def indexed_relations
    @indexed_relations ||= IndexedRelationsCollection.new relations, fk_names: [:parent_id]
  end

  def with_depth(depth)
    collection.select { |c| c.depth == depth }
  end

  def collection
    @colletion ||= @raw_collection.order(:depth).to_a
  end

  def relations
    @relations ||=
      ChildrenParent.where(children_type: 'Category', parent_type: %w[Category SportGroup])
  end
end
