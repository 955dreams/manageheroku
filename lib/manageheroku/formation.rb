module Manageheroku
  class Formation
    attr_reader :name
    def initialize(name, procs)
      @name = name
      @procs = procs
    end

    def update_params
      [@name, {updates: @procs}]
    end

  end
end
