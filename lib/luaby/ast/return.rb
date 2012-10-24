class Luaby::AST::Return
  attr_reader :explist
  
  def initialize(explist)
    @explist = explist
  end
  
  def to_lua
    if explist.any?
      "return #{explist.map(&:to_lua).join ", "}"
    else
      "return"
    end
  end
end