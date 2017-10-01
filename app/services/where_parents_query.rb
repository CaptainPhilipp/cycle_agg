# AR query, that returns childs, having all (not any) of concrete parents
class WhereParentsQuery
  def initialize(klass)
    @childs_class = klass
  end

  def call(*parents)
    @parents = parents

    build_query
  end

  private

  attr_reader :childs_class, :parents

  def build_query
    query_for_any_types
      .group(:id)
      .having('count(children_parents.parent_id) = ?', parents.size)
  end

  def query_for_any_types
    queries_for_types.inject { |accumulated_query, query| accumulated_query.or query }
  end

  def queries_for_types
    parent_ids_by_class.to_a.inject [] do |queries, class_and_ids|
      parent_class, parent_ids = class_and_ids

      queries << query_for(parent_type: parent_class.to_s, parent_id: parent_ids)
    end
  end

  def parent_ids_by_class
    @parents.group_by(&:class).transform_values { |parents| parents.map(&:id) }
  end

  def query_for(conditions_hash)
    childs_class
      .joins(:parent_associations)
      .where(children_parents: conditions_hash)
  end
end
