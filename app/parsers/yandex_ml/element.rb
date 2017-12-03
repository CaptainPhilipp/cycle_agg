# frozen_string_literal: true

module YandexML
  class Element
    def initialize(node, parent_object = nil)
      @parent_object = parent_object
      @node = node
    end

    class << self
      private

      def str_attributes(attribute_names)
        attribute_names.each do |name|
          define_method(name.underscore) { str_attribute(name) }
          define_method("raw_#{name.underscore}") { str_attribute(name) }
        end
      end

      def int_attributes(attribute_names)
        attribute_names.each do |name|
          define_method(name.underscore) { int_attribute(name) }
          define_method("raw_#{name.underscore}") { str_attribute(name) }
        end
      end

      def str_parameters(*attribute_names)
        attribute_names.each do |name|
          define_method(name.underscore) { str_parameter(name) }
          define_method("raw_#{name.underscore}") { str_parameter(name) }
        end
      end

      def int_parameters(*attribute_names)
        attribute_names.each do |name|
          define_method(name.underscore) { int_parameter(name) }
          define_method("raw_#{name.underscore}") { str_parameter(name) }
        end
      end

      def bool_parameters(default, *attribute_names)
        attribute_names.each do |name|
          define_method("#{name.underscore}?") { bool_parameter(name, default: default) }
          define_method("raw_#{name.underscore}") { str_parameter(name) }
        end
      end
    end

    def int_parameter(name)
      parameter(name).to_i
    end

    def parameter(name)
      node_text_content(children_by_name(name))
    end
    alias str_parameter parameter

    private

    attr_reader :node, :parent_object

    def bool_parameter(name, default: nil)
      string_to_bool(parameter(name), default)
    end

    def string_to_bool(string, default = nil)
      case string
      when 'true', 't', '1'  then true
      when 'false', 'f', '0' then false
      when nil               then default
      else raise 'Wrong value in document'
      end
    end

    def int_attribute(name)
      attribute(name).to_i
    end

    def attribute(name)
      node.str_attributes[name].value
    end
    alias str_attribute attribute

    def node_text_content(some_node)
      some_node.children.first.text
    end

    def children_by_name(name)
      childrens = indexed_childrens[name]
      childrens.first if childrens.size == 1
    end

    def childrens_by_name(name)
      indexed_childrens[name]
    end

    def indexed_childrens
      @indexed_childrens ||= node.children.group_by(&:name)
    end
  end
end
