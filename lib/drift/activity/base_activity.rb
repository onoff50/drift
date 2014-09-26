module Drift

  class BaseActivity

    attr_accessor :name, :desc

    def initialize(name, desc)
      @name = name
      @desc = desc
    end

    def run
      raise "Not Implemented"
    end

  end

end