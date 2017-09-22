require 'capybara'
require 'capybara/rspec'
require_relative 'page_object_helper'

module PageObject
  ERROR_CSS_CLASS = '.alert-error'.freeze

  def initialize(capybara_page_obj)
    @browser = capybara_page_obj
  end

  def visit(path)
    @browser.visit path
    self
  end

  def has_element?(name_with_type)
    send name_with_type
    true
  rescue Capybara::ElementNotFound
    false
  end

  def self.included(cls)
    cls.extend ClassMethods
  end

  module ClassMethods
    include PageObjectHelper

    %i[h1 h2 h3 h4 h5 h6 span label].each do |element_type|
      define_method element_type do |name, arguments|
        arguments[:element_type] = element_type
        span_element(name, arguments)
      end
    end

    def button(name, *arguments)
      type = :button
      selector = discover_selector(arguments, 'input')

      define_object_readers type, name, selector
    end

    def submit(*arguments)
      options = arguments.last.is_a?(Hash) ? arguments.last : {}
      name    = arguments.first.is_a?(Symbol) ? arguments.first : :submit
      value   = arguments.find { |a| a.is_a?(String) }
      options.merge(value: value) if value
      button(name, options.merge(type: :submit))
    end

    def link(name, *arguments)
      type = :link
      selector = discover_selector(arguments)

      define_object_readers type, name, selector
      define_method("#{name}_text") { @browser.find(selector).text }
    end

    def span_element(name, *arguments)
      type = arguments.last[:element_type] || 'span'
      selector = discover_selector(arguments)

      define_all_readers type, name, selector, :text
    end

    def text_area(name, *arguments)
      type = :text_area
      selector = discover_selector(arguments, 'input')

      define_writer            name, selector
      define_all_readers type, name, selector, :text
    end

    def text_field(name, *arguments)
      type = :text_area
      selector = discover_selector(arguments, 'input')

      define_writer            name, selector
      define_all_readers type, name, selector, :value
    end

    def file_field(name, *arguments)
      type = :file_field
      selector = discover_selector(arguments, 'input')

      define_all_readers type, name, selector, :value

      define_method "attach_file_to_#{name}" do |filepath|
        @browser.attach_file selector, filepath
      end
    end

    def select_list(name, *arguments) # rubocop:disable Metrics/MethodLength, Metric/AbcSize
      type = :select_list
      selector = discover_selector(arguments)

      define_all_readers type, name, selector, :value

      define_method("#{name}=") do |value|
        option_text = @browser.find("#{selector} option[value='#{value}']") ||
                      @browser.find("#{selector} option[text='#{value}']")
        @browser.find(selector).select option_text
      end

      define_method("select_nth_option_in_#{name}") do |value|
        option_text = @browser.find("#{selector} option:nth-child(#{value})").text
        @browser.find(selector).select option_text
      end

      define_method("#{name}_number_of_arguments") do
        @browser.all("#{selector} option[value!='']").length
      end
    end

    def check_box(name, *arguments)
      selector = discover_selector(arguments)

      define_element :checkbox, name, selector
      define_checker name, selector, :check
      define_checker name, selector, :uncheck

      define_method("#{name}_checkbox_is_checked?") { @browser.find(selector)['checked'] }
    end

    def table(name, *arguments)
      type = :table
      selector = discover_selector(arguments)

      define_object_readers type, name, selector
    end

    def form(name, *arguments)
      type = :form
      selector = discover_selector(arguments)

      define_object_readers type, name, selector

      define_method("#{name}_form_has_errors?") do
        @browser.within(:css, selector) do
          @browser.has_selector? ERROR_CSS_CLASS
        end
      end
    end
  end
end
