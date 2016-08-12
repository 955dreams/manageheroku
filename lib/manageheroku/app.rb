module Manageheroku
  class App
    attr_reader :name
    def initialize(name, attributes)
      @name = name
      @attributes = attributes
    end

    def update_params
      [@name, @attributes]
    end

  end
end
