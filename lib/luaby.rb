module Luaby
  require "luaby/syntax_error"
  require "luaby/parser"
  require "luaby/token"
  require "luaby/lexer"
  require "luaby/ast"
  
  INDENT = "    "
  
  def self.lex(source)
    Lexer.new(source).read
  end
  
  def self.parse(source)
    Parser.new(lex(source)).parse
  end
end