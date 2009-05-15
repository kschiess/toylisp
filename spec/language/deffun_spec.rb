# (defun should-be-constant ()
#   '(one two three))

require File.dirname(__FILE__) + '/../spec_helper'

describe '(defun should-be-constant () \'(one two three))' do
  attr_reader :lisp
  before(:each) do
    @lisp = Lisp.new
  end
  
  it "should execute [:deffun :foo [] '[42]]" do
    lisp.run(
      [:deffun, :foo, [], [42]])
  end
  context 'after deffun :foo' do
    before(:each) do
      lisp.run(
        [:deffun, :foo, [], [42]])
    end
    
    it "should have :foo defined in the namespace" do
      lisp.namespace.get(:foo).should_not be_nil
    end 
    it "should allow calling :foo" do
      lisp.run(
        [:foo]).should == 42
    end 
  end
end