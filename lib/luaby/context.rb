module Luaby
  class Context
    def initialize
      @globals = {}
    end
    
    def [](global)
      @globals[global]
    end
    
    def []=(globals, val)
      @globals[globals] = val
    end
    
    def _add(a, b)
      if a.is_a? Float and b.is_a? Float
        a + b
      else
        # @TODO
      end
    end
    
    def _sub(a, b)
      if a.is_a? Float and b.is_a? Float
        a - b
      else
        # @TODO
      end
    end
    
    def _mul(a, b)
      if a.is_a? Float and b.is_a? Float
        a * b
      else
        # @TODO
      end
    end
    
    def _div(a, b)
      if a.is_a? Float and b.is_a? Float
        a / b
      else
        # @TODO
      end
    end
    
    def _mod(a, b)
      if a.is_a? Float and b.is_a? Float
        a % b
      else
        # @TODO
      end
    end
    
    def _pow(a, b)
      if a.is_a? Float and b.is_a? Float
        a ** b
      else
        # @TODO
      end
    end
  end
end