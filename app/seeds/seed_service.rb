require_relative 'structs'
require_relative 'related_collection'

# knows structs, models, RelatedCollection
class SeedService
  def initialize
    @seed = RelatedCollection.new
  end

  def call(categories)
    ApplicationRecord.transaction do
      delete_all SportGroup, Category, ChildrenParent

      categories.each do |struct|
        record = create_record_from_struct(struct)
        seed.write record, pks(struct)
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

  def create_record_from_struct(struct)
    model = model_by struct.depth
    hash  = hash_from struct, for_model: model
    model.create hash
  end

  def model_by(depth)
    { 0 => SportGroup, 1 => Category, 2 => Category }[depth]
  end

  def hash_from(struct, for_model:)
    struct.to_h.select { |key, _| permit_attributes(for_model).include? key }
  end

  def permit_attributes(model)
    { SportGroup => %i[ru_title en_title],
      Category   => %i[ru_title en_title depth]
    }.fetch(model) # rubocop:disable Layout/MultilineHashBraceLayout
  end

  def pks(struct, key_name = :parent_titles)
    struct.send key_name if struct.respond_to? key_name
  end

  attr_reader :seed
end
