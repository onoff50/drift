

module Drift

  class BaseActivity

    attr_accessor :name, :desc

    def initialize(name, desc)
      @name = name
      @desc = desc
    end
  end

end