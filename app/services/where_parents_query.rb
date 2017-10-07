# frozen_string_literal: true

# AR query, that returns childs, having all (not any) of concrete parents
class WhereParentsQuery
  def initialize(klass)
    @childs_class = klass
  end

  # records: [record1, record2, record3]
  # ids:     { Type1: [1, 2], Type2: [3] }
  def call(parents)
    @parents = parents
    return childs_class.none if parents.empty?
    if parents.is_a? Hash
      build_query(subqueries_by_hash, parents_count_in_hash)
    elsif parents.is_a? Array
      build_query(subqueries_by_records, parents.size)
    end
  end

  private

  attr_reader :childs_class, :parents

  def build_query(subqueries, parents_count)
    inject_orqueries(subqueries)
      .group(:id)
      .having('count(children_parents.parent_id) = ?', parents_count)
  end

  def parents_count_in_hash
    parents.values.inject(0) { |m, ids| m + ids.size }
  end

  def inject_orqueries(queries)
    queries.inject { |summarized_query, query| summarized_query.or(query) }
  end

  def subqueries_by_hash
    parents.to_a.map do |type_ids|
      type, ids = type_ids
      query_for(parent_type: type, parent_id: ids) if ids&.any?
    end.compact
  end

  def subqueries_by_records
    grouped_by_class.to_a.inject [] do |queries, klass_ids|
      klass, ids = klass_ids
      queries << query_for(parent_type: klass.to_s, parent_id: ids)
    end
  end

  def grouped_by_class
    parents.group_by(&:class).transform_values { |parents| parents.compact.map(&:id) }
  end

  def query_for(conditions_hash)
    childs_class
      .joins(:parent_associations)
      .where(children_parents: conditions_hash)
  end
end
