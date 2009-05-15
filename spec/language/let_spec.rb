require File.dirname(__FILE__) + '/../spec_helper'

describe '(let (a 1) ())' do
  attr_reader :lisp
  before(:each) do
    @lisp = Lisp.new
  end
  
  it "should have an empty namespace initially" do
    lisp.namespace.should be_empty
  end
  it "should run [:let [:a :value] []]" do
    lisp.run(
      [:let, [:a, :value], []])
  end
  context ':a => 42' do
    before(:each) do
      lisp.namespace.push(
        :a => 42)
    end
    it "should evaluate [:a] to 42" do
      lisp.run([:a]).should == 42
    end
  end
  describe "effect of [:let [:a :value] []]" do
    it "should have a mapping of :a to :value" do
      lisp.run(
        [:let, [:a, :value], [:a]])

      lisp.run([:a]).should == :value
    end
  end
end