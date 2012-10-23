class Luaby::AST::LocalDeclaration
  attr_reader :namelist
  
  def initialize(namelist)
    @namelist = namelist
  end
end