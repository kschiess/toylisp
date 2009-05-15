class Lisp
  class Namespace
    attr_reader :bindings
    def initialize
      @bindings = []
    end
    
    def empty?
      bindings.empty?
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
    
  attr_reader :namespace
  def initialize
    @namespace = Namespace.new
  end
  
  def run(expression)
    expression = [*expression]
    
    # p expression
    form = expression.shift
    
    case form
      when :let
        varlist, code = expression
        namespace.push Hash[*varlist]
        return run(code)
      when Symbol
        return namespace.get(form)
    end
  end
end