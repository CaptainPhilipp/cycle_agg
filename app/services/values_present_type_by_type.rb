# frozen_string_literal: true

# functional object, calculates present_type by given data
class ValuesPresentTypeByType
  CHECKBOX = 'checkbox'
  BUTTON   = 'button'
  SLIDER   = 'slider'

  def initialize(parameter, values, locale = :en, max: 30)
    @parameter = parameter
    @values = values
    @locale = locale
    @max = max
  end

  def call
    parameter.present_type ||= calculate_present_type
  end

  def self.call(*args)
    new(*args).call
  end

  private

  attr_reader :parameter, :values, :locale, :max

  def calculate_present_type
    case parameter.values_type
    when 'ListValue'
      oversized_titles? ? CHECKBOX : BUTTON
    when 'RangeValue'
      oversized_range_nums? ? SLIDER : BUTTON
    end
  end

  def oversized_titles?
    title = "#{locale}_title".to_sym
    values.max_by { |v| v.send(title).size }.send(title).size * values.size > max
  end

  def oversized_range_nums?
    values.map(&:to_s).max_by(&:size).size > max
  end
end
