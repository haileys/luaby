class Luaby::AST::TableLookup
  attr_accessor :table, :index
  
  def initialize(table, index)
    @table = table
    @index = index
  end
  
  def prefix_exp?
    true
  end
  
  def to_lua
    table_lua = table.to_lua
    unless table.respond_to? :prefix_exp? and table.prefix_exp?
      table_lua = "(#{table_lua})"
    end
    if index.is_a? Luaby::AST::StringLiteral and index.valid_name?
      "#{table_lua}.#{index.string}"
    else
      "#{table_lua}[#{index.to_lua}]"
    end
  end
end