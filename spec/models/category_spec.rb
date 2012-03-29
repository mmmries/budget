require 'spec_helper'

describe Category do
  #The category structure should be:
  # r1
  #   + c1
  #   + c2
  # r2
  let(:r2){ Category.new( :name => "r2", :position => 2) }
  let(:c1){ Category.new( :name => "c1") }
  let(:c2){ Category.new( :name => "c2") }
  let(:r1){ 
    c = Category.new( :name => "r1", :position => 1)
    c.children << c1
    c.children << c2
    c
  }
  
  it "should have a name, a position and children" do
    r1.name.should == "r1"
    r1.position.should == 1
    r1.children.should_not be_nil
  end
  
  it "should have sorted children" do
    r1.save
    r1.children.first.name.should == "c1"
    r1.children.first.position.should == 0
    r1.children.last.name.should == "c2"
    r1.children.last.position.should == 1
    
    r1.children << Category.new(:name => "c3")
    r1.save
    r1.children.last.name.should == "c3"
    r1.children.last.position.should == 2
  end
  
  it "should allow resorting" do
    r1.save
    child = r1.children.last
    child.move_to(0, child.parent)
    r1.save
    
    r1 = Category.roots.first
    r1.children.first.name.should == "c2"
    r1.children.last.name.should == "c1"
  end
  
  it "should delete all children when it gets deleted" do
    r1.save
    r2.save
    Category.roots.each do |r|
      r.destroy
    end
    Category.all.size.should == 0
  end
end
