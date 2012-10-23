class Luaby::Token
  attr_accessor :type, :value, :line, :column, :offset, :source
  
  def initialize(type, value, line, column, offset, source)
    @type   = type
    @value  = value
    @line   = line
    @column = column
    @offset = offset
    @source = source
  end
end