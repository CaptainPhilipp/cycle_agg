# frozen_string_literal: true

# gives access to records by foreign or primary keys
class IndexedCollection < Delegator
  attr_reader :collection

  def __getobj__
    @collection
  end

  def initialize(collection)
    @collection = collection
    @indexed_collections = {}
  end

  # by_key(id: 1, foo: 1) # => object1_foo1
  def by_key(args)
    collection_by_key(args).tap { |results| raise TooManyResults if results&.size&.> 1 }&.first
  end

  # by_keys(id: [1, 2]) # => [object1, object2]
  def by_keys(args)
    index_name, index = args.first
    finded = collection_indexed_by_key(index_name).values_at(*index).compact
    finded.map(&:first)
  end

  # collection_by_key(foo: 1, bar: 1) # => [object1_foo1_bar1, object2_foo1_bar1]
  def collection_by_key(args)
    if args.size > 1
      collection_indexed_by_keys(args.keys)[args] || []
    else
      index_name, index_value = args.first
      collection_indexed_by_key(index_name)[index_value] || []
    end
  end

  # private

  attr_reader :indexed_collections

  def collection_indexed_by_key(index_name)
    indexed_collections[index_name] ||= collection.group_by(&index_name)
  end

  def collection_indexed_by_keys(index_names)
    indexed_collections[index_names.sort] ||= collection.group_by do |object|
      build_hash(object).select { |key| index_names.include? key }
    end
  end

  def build_hash(object)
    object.serializable_hash.transform_keys(&:to_sym)
  end

  # Exception for methods, that returns only one result by primary key
  class TooManyResults < RuntimeError
    def message
      'There are more than one object with current key. Use another key or method'
    end
  end
end
