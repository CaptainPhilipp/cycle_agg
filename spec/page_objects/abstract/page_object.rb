require 'capybara'
require 'capybara/rspec'
require_relative 'page_object_helper'

module PageObject
  ERROR_CSS_CLASS = '.alert-error'.freeze

  def initialize(capybara_page_obj, path = nil)
    @browser = capybara_page_obj
    @path = path
  end

  def visit
    @browser.visit @path
    self
  end

  def has_element?(name_with_type)
    send name_with_type
    true
  rescue Capybara::ElementNotFound
    false
  end

  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    include PageObjectHelper

    %i[h1 h2 h3 h4 h5 h6 span label].each do |element_type|
      define_method element_type do |name, arguments|
        arguments[:element_type] = element_type
        span_element(name, arguments)
      end
    end

    # %name%_button_selector # xpath selector
    # %name%_selector        # xpath selector
    # %name%_button          # element
    # %name%                 # => click
    def button(name, *arguments)
      type = :button
      selector = discover_selector(arguments, 'input')

      define_object_readers type, name, selector
      define_clicker name, selector
    end

    # submit('Some text')         == button(:submit, type: :submit, value: 'Some text')
    # submit(:other, 'Some text') == button(:other, type: :submit, value: 'Some text')
    #
    # %name%_button_selector # xpath selector
    # %name%_selector        # xpath selector
    # %name%_button          # element
    # %name%                 # => click
    def submit(*arguments)
      options = arguments.last.is_a?(Hash) ? arguments.last : {}
      name    = arguments.first.is_a?(Symbol) ? arguments.first : :submit
      value   = arguments.find { |a| a.is_a?(String) }
      options[:value] = value if value
      options[:type] = :submit
      button(name, options)
    end

    # %name%_button       # => element
    # %name%_button_selector       # => xpath selector
    # %name%_selector              # => xpath selector
    # %name%_text  # => element.text
    # %name%       # => click
    def link(name, *arguments)
      type = :link
      selector = discover_selector(arguments)

      define_object_readers(type, name, selector)
      define_clicker name, selector
      define_method("#{name}_text") { @browser.find(selector).text }
    end

    # %name% # => element./value/text/anything/
    # %name%_button_selector # => xpath selector
    # %name%_selector        # => xpath selector
    # %name%_button          # => element
    def span_element(name, *arguments)
      type = arguments.last[:element_type] || 'span'
      selector = discover_selector(arguments)

      define_all_readers type, name, selector, :text
    end

    # %name% = value # => write value to field
    # %name% # => element./value/text/anything/
    # %name%_button_selector # => xpath selector
    # %name%_selector        # => xpath selector
    # %name%_button          # => element
    def text_area(name, *arguments)
      type = :text_area
      selector = discover_selector(arguments, 'input')

      define_writer            name, selector
      define_all_readers type, name, selector, :text
    end

    # %name% = value # => write value to field
    # %name% # => element./value/text/anything/
    # %name%_button_selector # => xpath selector
    # %name%_selector        # => xpath selector
    # %name%_button          # => element
    def text_field(name, *arguments)
      type = :text_area
      selector = discover_selector(arguments, 'input')

      define_writer            name, selector
      define_all_readers type, name, selector, :value
    end

    # %name% # => element./value/text/anything/
    # %name%_button_selector # => xpath selector
    # %name%_selector        # => xpath selector
    # %name%_button          # => element
    # attach_file_to_$name$  # => attach file; For attaching files `:name` attribute required
    def file_field(name, *arguments)
      type = :file_field
      selector = discover_selector(arguments)

      define_all_readers type, name, selector, :value

      define_method "attach_file_to_#{name}" do |filepath|
        name_for_capybara_attaching = arguments.last[:name]
        @browser.attach_file name_for_capybara_attaching, filepath
      end
    end

    # %name% # => element./value/text/anything/
    # %name%_button_selector # => xpath selector
    # %name%_selector        # => xpath selector
    # %name%_button          # => element
    #
    # %name% = value              # => select with value or text
    # select_nth_option_in_%name% # => select option by position
    # %name%_number_of_arguments  # => number of selection variants
    #
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

    # %name%_button # => element
    # check_%name%_checkbox # => check checkbox
    # check_%name%          # => check checkbox
    # %name%_checked?       # => is checkbox checked
    def check_box(name, *arguments)
      selector = discover_selector(arguments)

      define_element :checkbox, name, selector
      define_checkers name, selector

      define_method("#{name}_сhecked?") { @browser.find(selector)['checked'] }
    end

    # %name%_button_selector # xpath selector
    # %name%_selector        # xpath selector
    # %name%_button          # element
    def table(name, *arguments)
      type = :table
      selector = discover_selector(arguments)

      define_object_readers type, name, selector
    end

    # %name%_button_selector # xpath selector
    # %name%_selector        # xpath selector
    # %name%_button          # element
    # %name%_has_errors? # element have error class
    def form(name, *arguments)
      type = :form
      selector = discover_selector(arguments)

      define_object_readers type, name, selector

      define_method("#{name}_#{type}_has_errors?") do
        @browser.within(:css, selector) do
          @browser.has_selector? ERROR_CSS_CLASS
        end
      end
    end
  end
end
