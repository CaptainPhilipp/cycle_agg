module PageObjectHelper
  private

  def define_property(name, selector, meth)
    define_reader(name, selector, meth)
    define_writer(name, selector)
  end

  def define_all_readers(type, name, selector, meth)
    define_reader(name, selector, meth)
    define_object_readers(type, name, selector)
  end

  def define_object_readers(type, name, selector)
    define_selectors(type, name, selector)
    define_element(type, name, selector)
  end

  def define_reader(name, selector, meth = :value)
    define_method(name) { @browser.find(selector).send meth }
  end

  def define_writer(name, selector)
    define_method("#{name}=") { |value| @browser.find(selector).set(value) }
  end

  def define_selectors(type, name, selector)
    define_method("#{name}_#{type}_selector") { selector }
    define_method("#{name}_selector") { selector }
  end

  def define_element(type, name, selector)
    define_method("#{name}_#{type}") { @browser.find(selector) }
  end

  def define_checker(name, un_check)
    define_method("#{un_check}_#{name}_checkbox") do
      @browser.send un_check, @browser.find(selector)[:id]
    end
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

    extend_selector(selector, options, :type, :value, :name)
  end

  def extend_selector(selector, options, *arguments)
    arguments.each do |argument|
      value = options[argument]
      selector << "[#{argument}='#{value}']" if value
    end

    selector
  end
end
