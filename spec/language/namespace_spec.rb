require File.dirname(__FILE__) + '/../spec_helper'

describe Lisp::Namespace do
  attr_reader :namespace
  before(:each) do
    @namespace = Lisp::Namespace.new
  end
  
  it "should allow capturing the namespace" do
    namespace.push(:a => 1)
    n1 = namespace.capture
    
    namespace.pop; namespace.push(:a => 2)
    n2 = namespace.capture
    
    n1.get(:a).should == 1
    n2.get(:a).should == 2
  end 
  it "should allow setting values to toplevel namespace" do
    namespace.set(:a, :foobar)
    namespace.get(:a).should == :foobar
  end 
  it "should allow pushing variables" do
    lambda {
      namespace.push(
        :a => 1
      )
    }.should_not raise_error
  end 
  it "should return nil if a variable does not exist" do
    namespace.get(:foobar).should be_nil
  end 
  context ':a => 1' do
    before(:each) do
      namespace.push(:a => 1)
    end
    
    it "should allow lookup of :a" do
      namespace.get(:a).should == 1
    end 
    it "should do correct variable masking (after push)" do
      namespace.push(:a => 42)
      namespace.get(:a).should == 42
    end 
    it "should do correct variable masking (after pop)" do
      namespace.push(:a => 42)
      namespace.pop
      namespace.get(:a).should == 1
    end 
  end
end