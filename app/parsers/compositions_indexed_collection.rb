# frozen_string_literal: true

# Stores objects, that have attribute with collection of elements
# Returns objects, that have element in theirs collections
class CompositionsIndexedCollection
  def initialize(collection = [])
    @indexed_collections = {}
    @collection = collection
    @indecies = Set.new
  end

  def by_subelement(argument)
    if argument.is_a? Hash
      composition_name, subelement = argument.first
    else
      composition_name = nil
      subelement = argument
    end

    find(subelement, composition_name)
  end

  def add(*objects)
    @collection += objects

    indecies.each do |composition_name|
      indexed_by(composition_name).merge index_by(composition_name, objects)
    end
  end

  private

  attr_reader :collection, :indexed_collections, :indecies

  def find(subelement, composition_name = nil)
    indecies << composition_name
    indexed_by(composition_name)[subelement]
  end

  def indexed_by(composition_name)
    indexed_collections[composition_name] ||= index_by(composition_name)
  end

  def index_by(composition_name, objects = collection)
    hash = {}
    each_subelement(composition_name, objects) do |element, object|
      hash[element] ||= []
      hash[element] << object
    end
    hash
  end

  def each_subelement(composition_name, objects)
    objects.each do |object|
      composition_of(object, composition_name).each do |element|
        yield element, object
      end
    end
  end

  def composition_of(object, composition_name = nil)
    composition_name ? object.send(composition_name) : object
  end
end
