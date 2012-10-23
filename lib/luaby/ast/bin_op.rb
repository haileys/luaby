module Luaby::AST
  class BinOp
    attr_accessor :left, :right
    
    def initialize(left, right)
      @left = left
      @right = right
    end
  end
  
  class Or < BinOp
  end
  
  class And < BinOp
  end
  
  class LessThan < BinOp
  end
  
  class GreaterThan < BinOp
  end
  
  class LessThanEqual < BinOp
  end
  
  class GreaterThanEqual < BinOp
  end
  
  class NotEqual < BinOp
  end
  
  class Equal < BinOp
  end
  
  class Concat < BinOp
  end
  
  class Add < BinOp
  end
  
  class Subtract < BinOp
  end
  
  class Multiply < BinOp
  end
  
  class Divide < BinOp
  end
  
  class Modulo < BinOp
  end
  
  class Power < BinOp
  end
end