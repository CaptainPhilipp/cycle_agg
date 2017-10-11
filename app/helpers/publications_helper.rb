# frozen_string_literal: true

module PublicationsHelper
  def show_values_for(parameter)
    menu_view =
      case parameter.values_type
      when 'ListValue'  then show_list_values_for
      when 'RangeValue' then show_range_values_for
      end

    menu_view.for_parents(parameter)
  end

  def show_list_values_for
    @list_values_by_parents ||= ChildsOfParents.new(@indexed_list_values, @indexed_relations)
  end

  def show_range_values_for
    @range_values_by_parents ||= ChildsOfParents.new(@indexed_range_values, @indexed_relations)
  end

  def checked?(parameter, value = nil)
    value_id = value ? value.id.to_s : ''
    params.dig(:parameters, parameter.id.to_s, :values)&.include? value_id
  end

  def values_name(parameter)
    "parameters[#{parameter.id}]values[]"
  end
end
