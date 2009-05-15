class Lisp
  class Binding
    attr_accessor :root
    attr_reader :variables
    
    def initialize(variables={}, root=nil)
      @root = root
      @variables = variables
    end
    def get(name)
      variables[name] ||
        root && root.get(name) ||
        nil
    end
    def set(name, value)
      variables[name] = value
    end
  end
  class Namespace
    attr_reader :current
    def initialize(binding = Binding.new)
      @current = binding
    end
    
    def push(variables)
      @current = Binding.new(variables, @current)
    end
    def pop
      @current = @current.root
    end
    
    def capture 
      Namespace.new(current)
    end
    
    def inspect
      h = {}
      c = current
      while c
        h.merge!(c.variables)
        c = c.root
      end
      h.inspect
    end
    
    def set(name, value) 
      raise 'Assertion error, toplevel binding is missing!' unless current
      current.set(name, value)
    end
    def get(name)
      current.get(name)
    end
  end
  class Function
    attr_reader :namespace
    def initialize(namespace, arguments, code)
      @namespace = namespace
      @arguments, @code = arguments, code
    end
    
    def call(arglist)
      binding = Hash[*@arguments.zip(arglist).flatten]
      namespace.push(binding)
      Lisp.new(namespace).run(@code)
    ensure
      namespace.pop
    end
    
    def inspect
      [@arguments, @code].inspect
    end
  end  
    
  attr_reader :namespace
  def initialize(namespace = Namespace.new)
    @namespace = namespace
  end
  
  def run(expression)
    expression = [*expression].dup
        
    # p expression
    form = expression.shift
    
    case form
      when :let
        varlist, code = expression
        namespace.push Hash[*varlist]
        return run(code)
      when :deffun
        funname, arglist, code = expression
        function = Function.new(namespace.capture, arglist, code)
        namespace.set(funname, function)
        return function
      when :if
        cond, true_branch, false_branch = expression
        
        if run(cond)
          return run(true_branch)
        else
          return run(false_branch)
        end
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