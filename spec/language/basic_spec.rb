require File.dirname(__FILE__) + '/../spec_helper'

# ( val )     val()
# ( val 1 2 ) 1, 2, val(1, 2)


describe "Basic language features (REHOIST?)" do
  attr_reader :lisp 
  before(:each) do
    @lisp = Lisp.new
  end
  
  def pattern_match(pattern, fragment)
    simple_matcher do |given, matcher|
      # matcher.description = "rhyme with #{expected.inspect}"
      # matcher.failure_message = "expected #{given.inspect} to rhyme with #{expected.inspect}"
      # matcher.negative_failure_message = "expected #{given.inspect} not to rhyme with #{expected.inspect}"
      given.match(pattern, fragment).should be_a_kind_of(Lisp::Match)
    end
  end
  
  it "should process a nop program and yield nil" do
    lisp.run([]).should be_nil
  end
  it "should run a program consisting of a simple value and return that" do
    lisp.run([:value]).should == :value
  end 
  describe "calling functions (foo 1 2)" do
    before(:each) do
      lisp.dictionary.add_function(:foo, [])
    end
    it "should look up foo in the current environment" do
      flexmock(lisp).should_receive(:look_up).with(:foo).once
      lisp.run([:foo, 1, 2])
    end
    it "should call foo with (1, 2)"
  end
  describe "defining functions" do
  end
end