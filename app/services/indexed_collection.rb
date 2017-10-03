# gives access to records by primary keys
class IndexedCollection
  attr_reader :records, :pk_name

  def initialize(records, pk: :id)
    raise ArgumentError if records.nil? || records.empty?
    @records = records
    @pk_name = pk
  end

  def by_pks(pks)
    indexed_records.values_at(*pks).compact
  end

  def by_pk(pk)
    indexed_records[pk]
  end

  private

  def indexed_records
    @indexed_records ||= index_records
  end

  def index_records
    hash = {}
    records.each { |record| hash[pk_of record] = record }
    hash
  end

  def pk_of(record)
    record.send pk_name
  end
end
