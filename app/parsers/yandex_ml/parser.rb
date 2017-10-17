# frozen_string_literal: true

module YandexMl
  # Adapter for Yandex markup language parser.
  class Parser
    def initialize(filepath)
      @filepath = filepath
    end

    def yml
      @file = open @filepath
      YandexML::File.new(@file)
    end

    def close
      @file.close
    end
  end
end
