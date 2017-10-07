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

  # by_keys(foo: 1, bar: 1) # => [object1_foo1_bar1, object2_foo1_bar1]
  # Only one value for every key - in other case, you will receive empty result
  def by_keys(conditions)
    if conditions.size > 1
      find_by_multiple_conditions(conditions) || []
    else
      find_by_one_condition(conditions.first) || []
    end
  end

  # by_key(id: [1, 2]) # => [object1, object2]
  # Only one key, but any count of values
  def by_key(conditions)
    raise TooManyKeys if conditions.size > 1
    key, value = conditions.first
    indexed_by_one(key).values_at(*value).compact.map(&:first)
  end

  private

  attr_reader :indexed_collections

  def find_by_multiple_conditions(conditions)
    indexed_by_multiple_keys(conditions.keys)[conditions.values]
  end

  def find_by_one_condition(key, value)
    indexed_by_one(key)[value]
  end

  def indexed_by_multiple_keys(keys)
    indexed_collections[keys] ||= collection.group_by do |object|
      keys.map { |key| object.send key }
    end
  end

  def indexed_by_one(key)
    indexed_collections[key] ||= collection.group_by(&key)
  end

  # Exception for methods, that returns only one result by primary key
  class TooManyKeys < RuntimeError
    def message
      'There are more than one object with current key. Use another key or method'
    end
  end
end
