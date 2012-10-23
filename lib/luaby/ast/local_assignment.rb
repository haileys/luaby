class Luaby::AST::LocalAssignment
  attr_reader :namelist, :explist
  
  def initialize(namelist, explist)
    @namelist = namelist
    @explist = explist
  end
end