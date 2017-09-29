require_relative 'structs'
require_relative 'related_collection'

# knows structs, models, RelatedCollection
class SeedService
  def initialize
    @seed = RelatedCollection.new
  end

  def call(categories)
    ApplicationRecord.transaction do
      delete_all Category, ChildrenParent

      categories.each do |struct|
        seed.write Category.create(hash_from(struct)), pks(struct)
      end

      seed.each_relation do |children, parent|
        ChildrenParent.create children: children, parent: parent
      end
    end
  end

  private

  def delete_all(*models)
    models.each(&:delete_all)
  end

  def hash_from(struct)
    struct.to_h.select { |key, _| %i[ru_title en_title depth].include? key }
  end

  def pks(struct, key_name = :parent_titles)
    struct.send key_name if struct.respond_to? key_name
  end

  attr_reader :seed
end
