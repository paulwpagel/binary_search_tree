require 'node'

describe Node do
  
  it "has a left child" do
    Node.new.left.should be_nil
  end
  
  it "has a right child" do
    Node.new.right.should be_nil
  end
  
  it "can hold a value" do
    Node.new.value.should be_nil
  end
  
  it "sets the value" do
    node = Node.new(10)
    node.value.should == 10
  end
  
  it "sets parent" do
    node = Node.new(10)
    node.value.should == 10
    new_node = Node.new(12, node)
    new_node.parent.should == node
  end
  
end
  
