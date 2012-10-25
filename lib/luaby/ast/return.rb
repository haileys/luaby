class Luaby::AST::Return
  attr_reader :explist
  
  def initialize(explist)
    @explist = explist
  end
  
  def to_lua
    if explist and explist.expressions.any?
      "return #{explist.to_lua}"
    else
      "return"
    end
  end
end