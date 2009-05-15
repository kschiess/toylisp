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
    attr_reader :interpreter
    def initialize(interpreter, arguments, code)
      @interpreter = interpreter
      @arguments, @code = arguments, code
    end
    
    def call(arglist)
      binding = Hash[*@arguments.zip(arglist).flatten]
      interpreter.namespace.push(binding)
      interpreter.run(@code)
    ensure
      interpreter.namespace.pop
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
        function = Function.new(self, arglist, code)
        namespace.set(funname, function)
        return function
      when Symbol
        value = namespace.get(form)
        if value.instance_of?(Function) 
          return funcall(value, expression)
        else
          return value
        end
    else
      return form
    end
  end
  
  def funcall(function, arguments)
    arglist = arguments.map { |arg| run(arg) }

    function.call(arglist)
  end
end