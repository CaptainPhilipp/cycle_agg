#
# Serializes as Singleton and Deserializes as Object
class CategoryAdressSerializer
  DELIMETER = ':'.freeze
  IDS_PATTERN    = /\A[\d#{DELIMETER}]*[^A-z]\z/
  TITLES_PATTERN = /\A[A-z#{DELIMETER}\-]*\z/

  def initialize(string)
    @string = string
  end

  def ids
    raise ArgumentError unless type == :id
    values
  end

  def values
    @identificators ||=
      case type
      when :short_title then string_to_array
      when :id          then string_to_array.map(&:to_i)
      else raise ArgumentError, 'Wrong identificators string'
      end
  end

  def type
    @type ||=
      case @string
      when IDS_PATTERN    then :id
      when TITLES_PATTERN then :short_title
      end
  end

  class << self
    def to_ids(*categories)
      categories.map(&:id).join(DELIMETER)
    end

    def to_short_titles(*categories)
      categories.map(&:short_title).join(DELIMETER)
    end
  end

  private

  def string_to_array
    @string.split(DELIMETER)
  end
end
