require File.dirname(__FILE__) + '/../spec_helper'

describe '#reverse' do
  attr_reader :lisp
  before(:each) do
    @lisp = Lisp.new
  end
  
  it 'should correctly reverse a list' do
    lisp.run(
      [
        [:deffun, :reverse, [:list], [
          [:if, [:nil?, :list],
            [],
            [:cons, [:reverse, [:tail, :list]]]]]],
            
        [:reverse, [1, 2, 3]]]).should == [3, 2, 1]
  end
end