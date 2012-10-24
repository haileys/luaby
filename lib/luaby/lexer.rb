class Luaby::Lexer
  KEYWORDS = %w(and break do else elseif end false for function goto if in
                local nil not or repeat return then true until while)
  
  OPERATORS = %w(... .. . == ~= <= >= < > :: : = # + - * / % ^ , ; ( ) { } [ ])
  
  TOKENS = [
    *OPERATORS.map { |op| [op, /\A#{Regexp.escape op}/] },
    *KEYWORDS.map { |kw| [kw, /\A#{kw}(?![a-zA-Z0-9_])/ ] },
    [ :whitespace,  /\A\s+/             ],
    [ :comment,     /--.*$/             ],
    [ :comment,     /--\[\[(.|\n)*\]\]/ ],
    [ :number,      /\A([0-9]+(\.[0-9]+)?([eE][0-9]+)?)/, ->md { md[1].to_f }       ],
    [ :number,      /\A0[xX]([0-9a-f]+)/,                 ->md { md[1].to_i.to_f }  ],
    [ :name,        /\A([a-zA-Z_][a-zA-Z0-9_]*)/,         ->md { md[1] }            ],
  ]
  
  attr_reader :source
  
  def initialize(source)
    @source = source
    @line = 1
    @col = 1
    @remaining = source
  end
  
  def read
    [].tap do |tokens|
      loop do
        tok = next_token
        tokens << tok
        break if tok.type == :EOF
      end
    end
  end
  
private  
  def next_token
    raw_next_token.tap do |tok|
      return next_token if [:comment, :whitespace].include? tok.type
    end
  end
  
  def error!(message, offset = 0)
    col = @col
    line = @line
    extra = @remaining[0, offset]
    newlines = extra.count "\n"
    if newlines.zero?
      col += extra.size
    else
      line += newlines
      col = extra.size - extra.rindex("\n")
    end
    raise Luaby::SyntaxError.new message, line, col
  end
  
  def make_token(type, value = nil)
    Luaby::Token.new type, value, @line, @col, (source.size - @remaining.size), source
  end

  def raw_next_token
    return make_token(:EOF) if @remaining.empty?
    
    return lex_string if ["\"", "'"].include? @remaining[0]
    
    TOKENS.each do |name, re, lambda|
      if md = re.match(@remaining)
        val = lambda[md] if lambda
        tok = make_token name, val
        @remaining = md.post_match
        return tok
      end
    end
    
    error! "Illegal character '#{@remaining[0]}'"
  end
  
  def lex_string
    delim = @remaining[0]
    str = ""
    in_escape = false
    in_zap = false
    
    escapes = { "a" => "\a", "b" => "\b", "f" => "\f", "n" => "\n", "r" => "\r",
                "t" => "\t", "v" => "\v", "\n" => "\n", "\r" => "\n",
                '"' => "\"", "'" => "'", "\\" => "\\" }
                
    index = 0
    loop do
      char = @remaining[index += 1]
      if char == "\\"
        char = @remaining[index += 1]
        if escapes[char]
          str << escapes[char]
        elsif char == "\r" or char == "\n"
          str << "\n"
        elsif char == "x" # hex escape
          x = @remaining[index + 1, 2]
          if /[a-f0-9]{2}/i !~ x
            error! "hexadecimal digit expected", index
          else
            str << x.to_i(16)
          end
        elsif char == "z" # zap
          while /\s/ =~ @remaining[index + 1]
            index += 1
          end
        elsif /[0-9]/ =~ char
          md = /[0-9]+/.match @remaining[index, 3]
          dec = md[0].to_i
          if dec > 255
            error! "decimal escape too large", index
          end
          str << dec
          index += md[0].length - 1
        else
          error! "invalid escape sequence", index
        end
      elsif char == "\r" or char == "\n" or char == nil # EOF  
        error! "unfinished string", index
      elsif char == delim
        break
      else
        str << char
      end
    end
    
    tok = make_token :string, str
    gobbled = @remaining[0, index]
    if gobbled.index "\n"
      @lines += gobbled.count "\n"
      @col = gobbled.size - gobbled.rindex("\n")
    else
      @col += gobbled.size
    end
    @remaining = @remaining[index..-1]
    tok
  end
end