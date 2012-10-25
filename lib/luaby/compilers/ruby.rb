module Luaby::Compilers
  class Ruby
    def initialize
      @scope_stack = [Scope::Global.new]
    end
    
    def compile(ast)
      ast.compile self
    end
    
    def scope
      @scope_stack.last
    end
    
    def close_scope
      begin
        @scope_stack.push Scope.new(scope)
        yield
      ensure
        @scope_stack.pop
      end
    end
  end
end