module Luaby
  class Parser
    def initialize(tokens)
      @tokens = tokens
    end
  
    def parse
      @index = -1
      chunk
    end

  private
    def prev_token
      @tokens[@index -= 1]
    end
  
    def next_token
      @tokens[@index += 1]
    end
  
    def peek_token
      @tokens[@index + 1]
    end
  
    def token
      @tokens[@index]
    end
  
    def error!(message)
      #require "pry"
      #pry binding
      raise Luaby::SyntaxError.new(message, token.offset, token.source)
    end
  
    def expect_token(*types)
      next_token.tap do |tok|
        error! "Expected #{types.map(&:inspect).join ", "}; got #{tok.type.inspect}" unless types.include? tok.type
      end
    end
  
    # ====
  
    def chunk
      AST::Chunk.new block(:EOF).statements
    end
  
    def block(end_delim = "end")
      block = block_leave_end end_delim
      expect_token end_delim
      block
    end
    
    def block_leave_end(*end_delims)
      statements = []
      until [*end_delims, "return"].include? peek_token.type
        statements << statement
      end
      statements << _return(*end_delims) if peek_token.type == "return"
      AST::Block.new statements.compact
    end
  
    def statement
      case peek_token.type
      when ";";         next_token; nil
      when "break";     next_token; AST::Break.new
      when "goto";      goto
      when "do";        _do
      when "while";     _while
      when "repeat";    repeat
      when "if";        _if
      when "for";       _for
      when "function";  function_statement
      when "local";     local_statement
      when "::";        label
      else
        # here's the tricky bit. lua's grammar is strange so we can't allow
        # just any expression here...
        exp = prefix_exp
        if [AST::Variable, AST::TableLookup].include? exp.class
          # this statement MUST be an assignment
          lvals = [exp]
          while peek_token.type == ","
            next_token
            lval = prefix_exp
            error! "Expected variable, index or member access" unless [AST::Variable, AST::TableLookup].include? lval.class
            lvals << lval
          end
          expect_token "="
          rvals = explist
          AST::Assignment.new lvals, rvals
        else
          # this statement MUST be a function call
          unless [AST::FunctionCall, AST::MethodCall].include? exp.class
            error! "Only function call or assignment allowed here"
          end
          exp
        end
      end
    end
    
    def goto
      expect_token "goto"
      AST::Goto.new expect_token(:name).value
    end
    
    def _do
      expect_token "do"
      block
    end
    
    def _while
      expect_token "while"
      condition = expression
      body = _do
      AST::While.new condition, body
    end
    
    def repeat
      expect_token "repeat"
      body = block "until"
      condition = expression
      AST::Repeat.new body, condition
    end
    
    def _if
      conditions = []
      bodies = []
      expect_token "if"
      conditions << expression
      expect_token "then"
      bodies << block_leave_end("elseif", "else", "end")
      while peek_token.type == "elseif"
        expect_token "elseif"
        conditions << expression
        expect_token "then"
        bodies << block_leave_end("elseif", "else", "end")
      end
      if peek_token.type == "else"
        expect_token "else"
        else_body = block_leave_end("end")
      end
      expect_token "end"
      AST::If.new conditions, bodies, else_body
    end
    
    def _for
      expect_token "for"
      name = expect_token :name
      if peek_token.type == "="
        # for Name in exp, exp [, exp] do block end
        expect_token "="
        from = expression
        expect_token ","
        to = expression
        if peek_token.type == ","
          expect_token ","
          step = expression
          body = _do
          AST::ForFromToStep.new name.value, from, to, step, body
        else  
          body = _do
          AST::ForFromTo.new name.value, from, to, body
        end
      else
        # for namelist in explist do block end
        prev_token
        lvals = namelist
        expect_token "in"
        rvals = explist
        body = _do
        AST::ForIn.new lvals, rvals, body
      end
    end
    
    def function_statement
      expect_token "function"
      names = [expect_token(:name).value]
      is_self_function = false
      while peek_token.type == "."
        expect_token "."
        names << expect_token(:name).value
      end
      if peek_token.type == ":"
        expect_token ":"
        is_self_function = true
        names << expect_token(:name).value
      end
      AST::FunctionDeclaration.new names, is_self_function, funcbody
    end
    
    def local_statement
      expect_token "local"
      if peek_token.type == "function"
        expect_token "function"
        name = expect_token(:name).value
        AST::LocalFunction.new name, funcbody
      else
        lvals = namelist
        if peek_token.type == "="
          expect_token "="
          rvals = explist
          AST::LocalDeclaration.new lvals, rvals
        else
          AST::LocalDeclaration.new lvals, []
        end
      end
    end
    
    def _return(*end_delims)
      expect_token "return"
      if end_delims.include? peek_token.type
        retn = AST::Return.new nil
      else
        retn = AST::Return.new explist
      end
      next_token if peek_token.type == ";"
      retn
    end
    
    def label
      expect_token "::"
      name = expect_token(:name).value
      expect_token "::"
      AST::Label.new name
    end
    
    def namelist
      names = [expect_token(:name).value]
      while peek_token.type == ","
        expect_token ","
        names << expect_token(:name).value
      end
      names
    end
    
    def explist
      names = [expression]
      while peek_token.type == ","
        expect_token ","
        names << expression
      end
      names
    end
    
    def funcbody
      expect_token "("
      params = parlist
      expect_token ")"
      body = block
      AST::Function.new params, body
    end
    
    def parlist
      if peek_token.type == "..."
        next_token
        AST::Parameters.new true, []
      elsif peek_token.type == ")"
        AST::Parameters.new false, []
      else
        params = [expect_token(:name).value]
        while peek_token.type == ","
          expect_token ","
          tok = expect_token :name, "..."
          if tok.type == "..."
            return AST::Parameters.new true, params
          end
          params << tok.value
        end
        AST::Parameters.new false, params
      end
    end
    
    def expression
      or_expression
    end
    
    def or_expression
      left = and_expression
      while peek_token.type == "or"
        next_token
        left = AST::Or.new left, and_expression
      end
      left
    end
    
    def and_expression
      left = rel_expression
      while peek_token.type == "and"
        next_token
        left = AST::And.new left, rel_expression
      end
      left
    end
    
    def rel_expression
      opers = { "<=" => AST::LessThanEqual,     "<"   => AST::LessThan,
                ">=" => AST::GreaterThanEqual,  ">"   => AST::GreaterThan,
                "~=" => AST::NotEqual,          "=="  => AST::Equal }
      left = concat_expression
      while opers.keys.include? peek_token.type
        node = opers[next_token.type]
        left = node.new left, concat_expression
      end
      left
    end
    
    def concat_expression
      left = add_expression
      if peek_token.type == ".."
        next_token
        AST::Concat.new left, concat_expression
      else
        left
      end
    end
    
    def add_expression
      opers = { "+" => AST::Add, "-" => AST::Subtract }
      left = mul_expression
      while opers.keys.include? peek_token.type
        node = opers[next_token.type]
        left = node.new left, mul_expression
      end
      left
    end
    
    def mul_expression
      opers = { "*" => AST::Multiply, "/" => AST::Divide, "%" => AST::Modulo }
      left = unary_expression
      while opers.keys.include? peek_token.type
        node = opers[next_token.type]
        left = node.new left, unary_expression
      end
      left
    end
    
    def unary_expression
      case peek_token.type
      when "not"; next_token; AST::Not.new    unary_expression
      when "-";   next_token; AST::Negate.new unary_expression
      when "#";   next_token; AST::Count.new  unary_expression
      else
        power_expression
      end
    end
    
    def power_expression
      left = primary_expression
      if peek_token.type == "^"
        next_token
        AST::Power.new left, power_expression
      else
        left
      end
    end
    
    def primary_expression
      case peek_token.type
      when "nil";       next_token; AST::Nil.new
      when "true";      next_token; AST::True.new
      when "false";     next_token; AST::False.new
      when :number;     AST::Number.new next_token.value
      when :string;     AST::StringLiteral.new next_token.value
      when "function";  next_token; funcbody
      when "...";       next_token; AST::Varargs.new
      when "{";         table_constructor
      else
        prefix_exp
      end
    end
    
    def table_constructor
      expect_token "{"
      pairs = []
      while peek_token.type != "}"
        if peek_token.type == "["
          expect_token "["
          key = expression
          expect_token "]"
          expect_token "="
          value = expression
          pairs << [key, value]
        elsif peek_token.type == :name
          next_token
          if peek_token.type == "="
            key = AST::StringLiteral.new token.value
            expect_token "="
            value = expression
            pairs << [key, value]
          else
            prev_token
            pairs << [nil, expression]
          end
        else
          pairs << [nil, expression]
        end
        expect_token ",", ";" unless peek_token.type == "}"
      end
      expect_token "}"
      AST::TableConstructor.new pairs
    end
    
    def prefix_exp
      expect_token :name, "("
      left = if token.type == "("
               exp = expression
               expect_token ")"
               exp
             else
               AST::Variable.new token.value
             end
      
      while ["(", ":", ".", "[", "{", :string].include? peek_token.type
        case peek_token.type
        when "(", "{", :string
          left = AST::FunctionCall.new left, args
        when "."
          next_token
          left = AST::TableLookup.new left, AST::StringLiteral.new(expect_token(:name).value)
        when "["
          next_token
          left = AST::TableLookup.new left, expression
          expect_token "]"
        when ":"
          next_token
          method = expect_token(:name).value
          left = AST::MethodCall.new left, method, args
        end
      end
      left
    end
    
    def args
      expect_token "{", "(", :string
      if token.type == "{"
        prev_token
        [table_constructor]
      elsif token.type == :string
        [AST::StringLiteral.new(token.value)]
      else
        if peek_token.type == ")"
          next_token
          []
        else
          args = explist
          expect_token ")"
          args
        end
      end
    end
  end
end