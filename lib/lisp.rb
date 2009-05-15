class Lisp
  class Namespace
    attr_reader :bindings
    def initialize
      @bindings = [{}]
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
    
    def set(name, value) 
      raise 'Assertion error, toplevel binding is missing!' if bindings.empty?
      bindings.last[name] = value
    end
    def get(name)
      bindings.reverse.each do |binding|
        if value=binding[name]
          return value
        end
      end
      nil
    end
  end
  class Function
    def initialize(arglist, code)
      @arglist, @code = arglist, code
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
      when :deffun
        funname, arglist, code = expression
        function = Function.new(arglist, code)
        namespace.set(funname, function)
        return function
      when Symbol
        return namespace.get(form)
    else
      return form
    end
  end
end