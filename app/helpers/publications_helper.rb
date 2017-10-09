# frozen_string_literal: true

module PublicationsHelper
  def show_values_for(parameter)
    menu_view =
      case parameter.values_type
      when 'ListValue'
        @list_values_view  ||= ChildrensView.new(@indexed_list_values, @indexed_relations)
      when 'RangeValue'
        @range_values_view ||= ChildrensView.new(@indexed_range_values, @indexed_relations)
      end

    menu_view.for_parents(parameter)
  end

  def checked?(parameter, value = nil)
    value_id = value ? value.id.to_s : ''
    params.dig(:parameters, parameter.id.to_s, :values)&.include? value_id
  end

  def values_name(parameter)
    "parameters[#{parameter.id}]values[]"
  end
end
