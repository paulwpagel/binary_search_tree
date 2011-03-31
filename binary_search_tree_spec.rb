require "binary_search_tree"

describe BinarySearchTree do
  
  before(:each) do
    @bst = BinarySearchTree.new(10)
  end
  
  it "has a root node" do
    @bst.root.should_not be_nil
  end
  
  it "sets a value for root node" do
    @bst.root.value.should == 10
  end
  
  context "#add" do
  
    it "inserts to the left" do
      @bst.add(5)
      @bst.root.left.value.should == 5
      @bst.root.left.parent.should == @bst.root
    end
  
    it "inserts to the right" do
      @bst.add(17)
      @bst.root.right.value.should == 17
    end
  
    it "adds to the second level" do
      @bst.add(5)
      @bst.add(7)
      @bst.root.left.right.value.should == 7
    end
  
    it "adds a whole bunch" do
      @bst.add(15)
      @bst.add(13)
      @bst.add(14)

      @bst.root.right.left.right.value.should == 14
    end
  end
  
  context "#delete" do
  
    it "deletes a leaf" do
      @bst.add(5)
      @bst.delete(5)
      @bst.root.left.should be_nil
    end
  
    it "deletes another leaf" do
      @bst.add(15)
    
      @bst.delete(15)
      @bst.root.right.should be_nil
    end
      
    it "deletes with one child" do
      @bst.add(5)
      @bst.add(4)
    
      @bst.delete(5)
      @bst.root.left.value.should == 4
    end
      
    it "deletes another with one child" do
      @bst.add(15)
      @bst.add(16)
    
      @bst.delete(15)
      @bst.root.right.value.should == 16
    end
      
    it "removes one grandchild" do
      @bst.add(15)
      @bst.add(16)
      @bst.add(17)
    
      @bst.delete(16)
      @bst.root.right.right.value.should == 17
    end
    10.times do 
      it "deletes successor with two children" do
        @bst.add(15)
        @bst.add(5)
        @bst.add(7)
        @bst.add(2)
        @bst.add(3)
      
        @bst.delete(5)
        if @bst.delete_strategy == :successor
          @bst.root.left.value.should == 7
        else
          @bst.root.left.value.should == 3
        end
      end
    end
    
  end
  
  context "#successor" do
    
    it "root's right is the trees in-order successor" do
      @bst.root.right = Node.new(15)
      @bst.successor.value.should == 15
    end
    
    it "finds a trees in-order successor" do
      @bst.root.right = Node.new(15)
      @bst.root.left = Node.new(9)
      @bst.root.right.right = Node.new(16)
      @bst.root.right.left = Node.new(12)
      @bst.root.right.left.right = Node.new(13)
      @bst.root.right.left.left = Node.new(11)
      @bst.root.right.right.right = Node.new(17)
      
      @bst.successor.value.should == 11
    end
    
  end
  
  context "#predecessor" do
    
    it "root's left is the trees in-order predecessor" do
      @bst.root.left = Node.new(9)
      @bst.predecessor.value.should == 9
    end
    
    it "finds a trees in-order predecessor" do
      @bst.root.right = Node.new(15)
      @bst.root.left = Node.new(5)
      @bst.root.left.left = Node.new(4)
      @bst.root.left.right = Node.new(7)
      @bst.root.left.right.right = Node.new(9)
      @bst.root.left.right.left = Node.new(6)
      
      @bst.predecessor.value.should == 9
    end
  end
end