require File.dirname(__FILE__) + '/../spec_helper'

describe Lisp::Namespace do
  attr_reader :namespace
  before(:each) do
    @namespace = Lisp::Namespace.new
  end
  
  it "should allow pushing variables" do
    lambda {
      namespace.push(
        :a => 1
      )
    }.should_not raise_error
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