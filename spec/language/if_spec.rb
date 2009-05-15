require File.dirname(__FILE__) + '/../spec_helper'

describe ':if' do
  attr_reader :lisp
  before(:each) do
    @lisp = Lisp.new
  end
  
  it "should correctly branch into true branch" do
    lisp.run([:if, [true], [1], [2]]).should == 1
  end 
  it "should correctly branch into true branch" do
    lisp.run([:if, [false], [1], [2]]).should == 2
  end 
end