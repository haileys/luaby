module Luaby
  class Scope
    class Global
      def parent
        nil
      end
      
      def local(var)
        raise "Can't create a local in global scope"
      end
      
      def ref(var)
        "ctx.globals[#{var.inspect}]"
      end
      
      def times_shadowed(var)
        0
      end
    end
    
    attr_reader :parent
    
    def initialize(scope)
      @parent = parent
      @locals = {}
    end
    
    def local(var)
      @locals[var] = "_#{var}_#{times_shadowed var}"
    end
    
    def ref(var)
      @locals[var] || parent.ref(var)
    end
    
    def times_shadowed(var)
      (@locals[var] ? 1 : 0) + parent.times_shadowed(var)
    end
  end
end