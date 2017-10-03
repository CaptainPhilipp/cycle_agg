# frozen_string_literal: true

# knows only pk method of record
class RelatedCollection
  attr_reader :records, :relations

  def initialize
    @records = {}
    @relations = {}
  end

  def write(record, parent_pks = nil)
    records[pk record]   = record
    relations[pk record] = parent_pks if parent_pks
  end

  def each_relation
    relations.each do |children_pk, parent_pks|
      children = by_pk(children_pk)

      parent_pks.each do |parent_pk|
        parent = by_pk(parent_pk)
        yield children, parent
      end
    end
  end

  private

  def pk(record)
    record.en_title
  end

  def by_pk(pk)
    records[pk]
  end
end
