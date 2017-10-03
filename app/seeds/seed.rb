# frozen_string_literal: true

require_relative 'structs'
require_relative 'related_collection'

# knows structs, models, RelatedCollection
class Seed
  def initialize
    @datastruct = RelatedCollection.new
  end

  def self.call
    service = new
    service.call { yield service }
    service
  end

  def call
    ApplicationRecord.transaction do
      delete_all ChildrenParent
      yield
      create_relations
    end
  end

  def write(model, collection)
    delete_all model
    collection.each { |struct| datastruct.write create(model, struct), parents(struct) }
  end

  private

  attr_reader :datastruct

  def delete_all(*models)
    models.each(&:delete_all)
  end

  def create_relations
    datastruct.each_relation do |children, parent|
      ChildrenParent.create children: children, parent: parent
    end
  end

  def create(model, struct)
    model.create hash_from(struct)
  end

  def parents(struct)
    struct.send parents_keyname if struct.respond_to? parents_keyname
  end

  def hash_from(struct)
    struct.to_h.reject { |key, _| key == parents_keyname }
  end

  def parents_keyname
    :parents
  end
end
