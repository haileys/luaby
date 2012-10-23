class Luaby::AST::TableLookup
  attr_accessor :table, :index
  
  def initialize(table, index)
    @table = table
    @index = index
  end
end