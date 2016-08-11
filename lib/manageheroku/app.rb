module Manageheroku
  class App
    attr_reader :name, :attributes
    def initialize(name, attributes)
      @name = name
      @attributes = attributes
    end

  end
end
