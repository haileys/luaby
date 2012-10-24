class Luaby::Token
  attr_accessor :type, :value, :offset, :source
  
  def initialize(type, value, offset, source)
    @type   = type
    @value  = value
    @offset = offset
    @source = source
  end

  def line
    source[0..offset].count("\n") + 1
  end
  
  def column
    source[0..offset].split("\n").last.size + 1
  end
end