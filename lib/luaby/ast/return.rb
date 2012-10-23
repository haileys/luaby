class Luaby::AST::Return
  attr_reader :explist
  
  def initialize(explist)
    @explist = explist
  end
end