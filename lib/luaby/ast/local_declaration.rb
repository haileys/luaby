class Luaby::AST::LocalDeclaration
  attr_reader :namelist, :explist
  
  def initialize(namelist, explist)
    @namelist = namelist
    @explist = explist
  end
end