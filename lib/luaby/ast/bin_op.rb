module Luaby::AST
  class BinOp
    attr_accessor :left, :right
    
    def initialize(left, right)
      @left = left
      @right = right
    end

    def associatity
      :left
    end
    
    def to_lua
      left_lua = left.to_lua
      
      if left.respond_to? :precedence
        if left.precedence < precedence
          left_lua = "(#{left_lua})"
        elsif left.respond_to? :associativity and left.associativity == :right and left.precedence == precedence
          left_lua = "(#{left_lua})"
        end
      end
      
      right_lua = right.to_lua
      
      if right.respond_to? :precedence
        if right.precedence < precedence
          right_lua = "(#{right_lua})"
        elsif right.respond_to? :associativity and right.associativity == :left and right.precedence == precedence
          right_lua = "(#{right_lua})"
        end
      end
      
      "#{left_lua} #{operator} #{right_lua}"
    end
  end
  
  class Or < BinOp
    def operator
      "or"
    end
    
    def precedence
      1
    end
  end
  
  class And < BinOp
    def operator
      "and"
    end
    
    def precedence
      2
    end
  end
  
  class LessThan < BinOp
    def operator
      "<"
    end
    
    def precedence
      3
    end
  end
  
  class GreaterThan < BinOp
    def operator
      ">"
    end
    
    def precedence
      3
    end
  end
  
  class LessThanEqual < BinOp
    def operator
      "<="
    end
    
    def precedence
      3
    end
  end
  
  class GreaterThanEqual < BinOp
    def operator
      ">="
    end
    
    def precedence
      3
    end
  end
  
  class NotEqual < BinOp
    def operator
      "~="
    end
    
    def precedence
      3
    end
  end
  
  class Equal < BinOp
    def operator
      "=="
    end
    
    def precedence
      3
    end
  end
  
  class Concat < BinOp
    def operator
      ".."
    end
    
    def precedence
      4
    end

    def associatity
      :right
    end
  end
  
  class Add < BinOp
    def operator
      "+"
    end
    
    def precedence
      5
    end
  end
  
  class Subtract < BinOp
    def operator
      "-"
    end
    
    def precedence
      5
    end
  end
  
  class Multiply < BinOp
    def operator
      "*"
    end
    
    def precedence
      6
    end
  end
  
  class Divide < BinOp
    def operator
      "/"
    end
    
    def precedence
      6
    end
  end
  
  class Modulo < BinOp
    def operator
      "%"
    end
    
    def precedence
      6
    end
  end
  
  class Power < BinOp
    def operator
      "^"
    end
    
    def precedence
      8
    end
    
    def associatity
      :right
    end
  end
end