

class Lisp
  class Namespace
    attr_reader :bindings
    def initialize
      @bindings = []
    end
    
    def push(binding)
      bindings.push(binding)
    end
    def pop
      bindings.pop
    end
    
    def get(name)
      bindings.reverse.each do |binding|
        if value=binding[name]
          return value
        end
      end
    end
  end
    
  def initialize
    @dictionary = Dictionary.new
  end
  
  def look_up(symbol)
    
  end
  
  def run(program)
    form = program.first
    
    if form.kind_of?(Symbol)
      value = look_up(form)
      
      # try to execute value as a function
      arguments = program[1..-1].map { |argument| 
        run(argument) }
        
      
    else 
      form
    end
  end
end