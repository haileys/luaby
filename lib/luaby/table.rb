class Luaby
  class Table
    attr_reader :array, :hash, :meta
    
    def initialize(meta = nil)
      @array = []
      @hash = {}
      @meta = meta
    end
    
    def [](key)
      if key.is_a? Float and key % 1.0 == 0.0
        
      end
    end
  end
end