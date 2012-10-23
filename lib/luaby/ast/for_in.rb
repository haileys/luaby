class Luaby::AST::ForIn
  attr_reader :namelist, :explist, :block
  
  def initialize(namelist, explist, block)
    @namelist = namelist
    @explist = explist
    @block = block
  end
end