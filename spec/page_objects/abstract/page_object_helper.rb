module PageObjectHelper
  private

  def define_property(name, selector, meth)
    define_content_reader(name, selector, meth)
    define_writer(name, selector)
  end

  def define_all_readers(type, name, selector, meth)
    define_content_reader(name, selector, meth)
    define_object_readers(type, name, selector)
  end

  def define_object_readers(type, name, selector)
    define_selectors(type, name, selector)
    define_element(type, name, selector)
  end

  # %name% # => element./value/text/anything/
  def define_content_reader(name, selector, meth = :value)
    define_method(name) { @browser.find(selector).send meth }
  end

  # %name% = value # => write value to field
  def define_writer(name, selector)
    define_method("#{name}=") { |value| @browser.find(selector).set(value) }
  end

  # %name%_button_selector # => xpath selector
  # %name%_selector        # => xpath selector
  def define_selectors(type, name, selector)
    define_method("#{name}_#{type}_selector") { selector }
    define_method("#{name}_selector") { selector }
  end

  # %name%_button_selector       # => xpath selector
  # %name%_selector              # => xpath selector
  # %name%_button_selector(text) # => xpath selector (with celector by text)
  # %name%_selector(text)        # => xpath selector (with celector by text)
  def define_selectors_(type, name, selector)
    define_method("#{name}_#{type}_selector") do |text = nil|
      text ? extend_selector(selector, :text, text) : selector
    end

    define_method("#{name}_selector") do |text = nil|
      text ? extend_selector(selector, :text, text) : selector
    end
  end

  # %name%_button # => element
  def define_element(type, name, selector)
    define_method("#{name}_#{type}") { @browser.find(selector) }
  end

  # check_%name%_checkbox # => check checkbox
  # check_%name%          # => check checkbox
  def define_checkers(name) # rubocop:disable Metrics/MethodLength, Metric/AbcSize
    define_method("#uncheck_#{name}_checkbox") do
      @browser.send :uncheck, @browser.find(selector)[:id]
    end

    define_method("check_#{name}_checkbox") do
      @browser.send :check, @browser.find(selector)[:id]
    end

    define_method("#uncheck_#{name}") do
      @browser.send :uncheck, @browser.find(selector)[:id]
    end

    define_method("check_#{name}") do
      @browser.send :check, @browser.find(selector)[:id]
    end
  end

  # %name% # => click
  def define_clicker(name, selector)
    define_method(name) { @browser.find(selector).click }
  end

  def discover_selector(arguments, prefix = nil)
    options = arguments.last

    if arguments.size > 1
      selector = prefix || arguments.first
    else
      selector = prefix || ''
      selector << "##{options[:id]}" if options[:id]
      selector << ".#{options[:class]}" if options[:class]
    end

    extend_selector_options(selector, options, :type, :value, :name)
  end

  def extend_selector_options(selector, options, *arguments)
    arguments.each do |argument|
      value = options[argument]
      extend_selector(selector, argument, value) if value
    end

    selector
  end

  def extend_selector(selector, argument, value)
    selector << "[#{argument}='#{value}']"
    selector
  end
end
