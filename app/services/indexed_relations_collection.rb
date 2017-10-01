# gives access to relation records by any foreign_keys
class IndexedRelationsCollection
  attr_reader :relations, :fk_names

  def initialize(relations, fk_names:)
    raise ArgumentError unless relations.respond_to? :each
    @fk_names = fk_names
    @relations = relations
  end

  def by_fk(value, fk_name = fk_names.first)
    indexed_relations[fk_name][value]
  end

  private

  def indexed_relations
    @indexed_relations ||= index_relations
  end

  def index_relations(hash = {})
    fk_names.each { |key| hash[key] = {} } # little optimize

    relations.each do |relation|
      fk_names.each do |fk_name|
        pk_value = relation.send fk_name
        hash[fk_name][pk_value] ||= []
        hash[fk_name][pk_value] << relation
      end
    end
    hash
  end
end
