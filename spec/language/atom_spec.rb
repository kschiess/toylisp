require File.dirname(__FILE__) + '/../spec_helper'

describe 'atoms' do
  attr_reader :lisp 
  before(:each) do
    @lisp = Lisp.new
  end
  
  it "should evaluate [123] to 123" do
    lisp.run(
      [123]).should == 123
  end 
end