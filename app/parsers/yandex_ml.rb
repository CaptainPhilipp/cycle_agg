# frozen_string_literal: true

module YandexML
  def self.from_file(filepath)
    from_xml File.read(filepath)
  end

  def self.from_xml(doc)
    base_node = Nokogiri::XML(doc)
    catalog_node = base_node.children.find { |e| e.is_a? Nokogiri::XML::Element }
    YandexML::Catalog.new(catalog_node)
  end
end
