module Luaby::AST
  class UnaryOp
    attr_accessor :operand
    
    def initialize(operand)
      @operand = operand
    end
    
    def precedence
      7
    end
    
    def to_lua
      if operand.respond_to? :precedence and operand.precedence <= precedence
        "#{operator}(#{operand.to_lua})"
      else
        "#{operator}#{operand.to_lua}"
      end
    end
  end
  
  class Negate < UnaryOp
    def operator
      "-"
    end
  end
  
  class Count < UnaryOp
    def operator
      "#"
    end
  end
  
  class Not < UnaryOp
    def operator
      "not "
    end
  end
end